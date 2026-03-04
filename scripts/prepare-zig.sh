#!/bin/bash
set -euo pipefail

ZIG_VERSION="0.13.0"
ZIG_ARCH="zig-linux-x86_64-${ZIG_VERSION}"
URL="https://ziglang.org/download/${ZIG_VERSION}/${ZIG_ARCH}.tar.xz"
STAMP="v13-musl-precached"

mkdir -p bin/zig-dist

if [ -f "bin/zig-dist/zig" ] && [ -f "bin/zig-dist/.stamp" ] && [ "$(cat bin/zig-dist/.stamp)" = "$STAMP" ]; then
    echo "[prepare-zig] bin/zig-dist already up to date (${STAMP}), skipping download."
    exit 0
fi

echo "[prepare-zig] Downloading zig ${ZIG_VERSION} (${STAMP})..."
rm -rf bin/zig-dist
mkdir -p bin/zig-dist
curl -fsSL "$URL" | tar xJ \
    --strip-components=1 \
    -C bin/zig-dist \
    "${ZIG_ARCH}/zig" \
    "${ZIG_ARCH}/lib"

chmod +x bin/zig-dist/zig

# Strip everything except what's needed for zig cc -target x86_64-linux-musl:
#   lib/include/      — clang builtin headers (stddef.h etc.)
#   lib/libc/include/ — C standard library headers
#   lib/libc/musl/    — musl libc source (needed for CRT objects at link time)
#   lib/compiler_rt*  — compiler runtime (link time)
#   lib/std/          — required by compiler_rt compilation
find bin/zig-dist/lib -maxdepth 1 -mindepth 1 \
    ! -name 'libc' \
    ! -name 'include' \
    ! -name 'compiler_rt' \
    ! -name 'compiler_rt.zig' \
    ! -name 'std' \
    -exec rm -rf {} +
find bin/zig-dist/lib/libc -maxdepth 1 -mindepth 1 \
    ! -name 'include' \
    ! -name 'musl' \
    -exec rm -rf {} +
# Keep only x86_64, generic, any headers
find bin/zig-dist/lib/libc/include -maxdepth 1 -mindepth 1 -type d \
    ! -name 'x86_64*' \
    ! -name 'generic*' \
    ! -name 'any*' \
    -exec rm -rf {} +

# Pre-warm: compile+link a trivial program to populate the zig global cache
# with musl CRT objects and compiler_rt. Store the cache in /tmp (outside the
# bundle dir) to avoid Vercel's bundler tripping on zig's internal hardlinks.
echo "[prepare-zig] Pre-warming zig cache for x86_64-linux-musl..."
ZIG_PREWARM_CACHE="/tmp/zig-prewarm-global"
ZIG_PREWARM_LOCAL="/tmp/zig-prewarm-local"
rm -rf "$ZIG_PREWARM_CACHE" "$ZIG_PREWARM_LOCAL"
mkdir -p "$ZIG_PREWARM_CACHE" "$ZIG_PREWARM_LOCAL"
printf 'int main(void){return 0;}\n' > /tmp/_adan_warmup.c
ZIG_LIB_DIR="$(pwd)/bin/zig-dist/lib" \
ZIG_GLOBAL_CACHE_DIR="$ZIG_PREWARM_CACHE" \
ZIG_LOCAL_CACHE_DIR="$ZIG_PREWARM_LOCAL" \
  bin/zig-dist/zig cc -target x86_64-linux-musl -march=x86_64 /tmp/_adan_warmup.c -o /tmp/_adan_warmup
rm -f /tmp/_adan_warmup.c /tmp/_adan_warmup

# Copy the pre-warmed cache object files into the bundle.
# Use cp -rL to dereference any symlinks so Vercel's bundler sees plain files.
mkdir -p bin/zig-dist/zig-cache
cp -rL "$ZIG_PREWARM_CACHE/." bin/zig-dist/zig-cache/
rm -rf "$ZIG_PREWARM_CACHE" "$ZIG_PREWARM_LOCAL"

# Source trees are now redundant — CRT and compiler_rt .o files are in cache
rm -rf bin/zig-dist/lib/libc/musl
rm -rf bin/zig-dist/lib/compiler_rt
rm -f  bin/zig-dist/lib/compiler_rt.zig
rm -rf bin/zig-dist/lib/std

echo "$STAMP" > bin/zig-dist/.stamp
echo "[prepare-zig] zig distribution ready at bin/zig-dist/ ($(du -sh bin/zig-dist | cut -f1))"


mkdir -p bin/zig-dist

if [ -f "bin/zig-dist/zig" ] && [ -f "bin/zig-dist/.stamp" ] && [ "$(cat bin/zig-dist/.stamp)" = "$STAMP" ]; then
    echo "[prepare-zig] bin/zig-dist already up to date (${STAMP}), skipping download."
    exit 0
fi

echo "[prepare-zig] Downloading zig ${ZIG_VERSION} (${STAMP})..."
rm -rf bin/zig-dist
mkdir -p bin/zig-dist
curl -fsSL "$URL" | tar xJ \
    --strip-components=1 \
    -C bin/zig-dist \
    "${ZIG_ARCH}/zig" \
    "${ZIG_ARCH}/lib"

chmod +x bin/zig-dist/zig

find bin/zig-dist/lib -maxdepth 1 -mindepth 1 \
    ! -name 'libc' \
    ! -name 'include' \
    ! -name 'compiler_rt' \
    ! -name 'compiler_rt.zig' \
    ! -name 'std' \
    -exec rm -rf {} +
find bin/zig-dist/lib/libc -maxdepth 1 -mindepth 1 \
    ! -name 'include' \
    ! -name 'glibc' \
    -exec rm -rf {} +
find bin/zig-dist/lib/libc/include -maxdepth 1 -mindepth 1 -type d \
    ! -name 'x86_64*' \
    ! -name 'generic*' \
    ! -name 'any*' \
    -exec rm -rf {} +

# Strip non-x86_64 glibc sysdeps
find bin/zig-dist/lib/libc/glibc/sysdeps -maxdepth 1 -mindepth 1 -type d \
    ! -name 'x86_64' \
    ! -name 'x86' \
    ! -name 'generic' \
    ! -name 'unix' \
    ! -name 'pthread' \
    -exec rm -rf {} +
find bin/zig-dist/lib/libc/glibc/sysdeps/unix/sysv/linux -maxdepth 1 -mindepth 1 -type d \
    ! -name 'x86_64' \
    ! -name 'generic' \
    -exec rm -rf {} +

echo "[prepare-zig] Pre-warming zig cache for x86_64-linux-gnu..."
ZIG_CACHE="$(pwd)/bin/zig-dist/zig-cache"
mkdir -p "$ZIG_CACHE"
printf 'int main(void){return 0;}\n' > /tmp/_adan_warmup.c
ZIG_LIB_DIR="$(pwd)/bin/zig-dist/lib" \
ZIG_GLOBAL_CACHE_DIR="$ZIG_CACHE" \
ZIG_LOCAL_CACHE_DIR="$ZIG_CACHE/local" \
  bin/zig-dist/zig cc -target x86_64-linux-gnu -march=x86_64 /tmp/_adan_warmup.c -o /tmp/_adan_warmup
rm -f /tmp/_adan_warmup.c /tmp/_adan_warmup

rm -rf bin/zig-dist/lib/libc/glibc
rm -rf bin/zig-dist/lib/compiler_rt
rm -f bin/zig-dist/lib/compiler_rt.zig
rm -rf bin/zig-dist/lib/std

echo "$STAMP" > bin/zig-dist/.stamp
echo "[prepare-zig] zig distribution ready at bin/zig-dist/ ($(du -sh bin/zig-dist | cut -f1))"

