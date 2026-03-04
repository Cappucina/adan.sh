#!/bin/bash
set -euo pipefail

ZIG_VERSION="0.13.0"
ZIG_ARCH="zig-linux-x86_64-${ZIG_VERSION}"
URL="https://ziglang.org/download/${ZIG_VERSION}/${ZIG_ARCH}.tar.xz"
STAMP="v15-prewarm-gnu"

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

# Pre-warm: compile a trivial C program targeting x86_64-linux-gnu.
# This forces zig to compile and cache:
#   - glibc CRT objects (crti.o, crtn.o, Scrt1.o, libc_nonshared.a)
#   - compiler_rt.a
# Store the global cache in /tmp first, then copy back with cp -rL to
# dereference zig's internal hardlinks so Vercel's bundler can package them.
echo "[prepare-zig] Pre-warming zig global cache for x86_64-linux-gnu..."
PREWARM_GLOBAL="/tmp/zig-prewarm-global-$$"
PREWARM_LOCAL="/tmp/zig-prewarm-local-$$"
rm -rf "$PREWARM_GLOBAL" "$PREWARM_LOCAL"
mkdir -p "$PREWARM_GLOBAL" "$PREWARM_LOCAL"

printf '#include <stdio.h>\nint main(void){puts("hi");return 0;}\n' > /tmp/_adan_warmup_$$.c
ZIG_LIB_DIR="$(pwd)/bin/zig-dist/lib" \
ZIG_GLOBAL_CACHE_DIR="$PREWARM_GLOBAL" \
ZIG_LOCAL_CACHE_DIR="$PREWARM_LOCAL" \
  bin/zig-dist/zig cc \
    -target x86_64-linux-gnu \
    -march=x86_64 \
    /tmp/_adan_warmup_$$.c \
    -o /tmp/_adan_warmup_$$
rm -f /tmp/_adan_warmup_$$.c /tmp/_adan_warmup_$$

echo "[prepare-zig] Pre-warm complete. Cache size: $(du -sh "$PREWARM_GLOBAL" | cut -f1)"

# lld.id is a linker lock file that may vanish after the build —
# remove any remnants before copying so cp -rL doesn't choke on them.
find "$PREWARM_GLOBAL" -name 'lld.id' -delete 2>/dev/null || true

# Dereference hardlinks and copy into the bundle directory.
rm -rf bin/zig-dist/zig-prewarm
mkdir -p bin/zig-dist/zig-prewarm
cp -rL "$PREWARM_GLOBAL/." bin/zig-dist/zig-prewarm/
rm -rf "$PREWARM_GLOBAL" "$PREWARM_LOCAL"

echo "[prepare-zig] Bundled pre-warm cache: $(du -sh bin/zig-dist/zig-prewarm | cut -f1)"

# Strip source trees that are no longer needed at runtime:
#   - lib/libc/glibc/  (CRT compiled, objects now in zig-prewarm cache)
#   - lib/compiler_rt* (compiled into zig-prewarm cache)
#   - lib/std/         (only needed to compile compiler_rt at build time)
# Keep:
#   - lib/include/          (clang builtin headers: stddef.h etc.)
#   - lib/libc/include/     (C standard library headers)
find bin/zig-dist/lib -maxdepth 1 -mindepth 1 \
    ! -name 'include' \
    ! -name 'libc' \
    -exec rm -rf {} +
find bin/zig-dist/lib/libc -maxdepth 1 -mindepth 1 \
    ! -name 'include' \
    -exec rm -rf {} +

# Keep only Linux/glibc target headers — drop Windows (74MB), macOS (8MB),
# generic-musl (not targeting musl), and x32 ABI (not needed).
find bin/zig-dist/lib/libc/include -maxdepth 1 -mindepth 1 -type d \
    ! -name 'x86_64-linux-gnu' \
    ! -name 'x86_64-linux-musl' \
    ! -name 'generic-glibc' \
    ! -name 'any-linux-any' \
    -exec rm -rf {} +

echo "$STAMP" > bin/zig-dist/.stamp
echo "[prepare-zig] zig distribution ready at bin/zig-dist/ ($(du -sh bin/zig-dist | cut -f1))"

