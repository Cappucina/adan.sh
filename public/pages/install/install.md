## Install ADAN

If you only want to use the compiler, start with the latest binaries from [Releases](https://github.com/Cappucina/ADAN/releases).

## Build the Compiler from Source

### Clone the repository

```bash
git clone https://github.com/Cappucina/ADAN.git
cd ADAN
```

### Install dependencies

ADAN uses [XMake](https://xmake.io/) as its build system.

```bash
xmake install
```

If you need to run the dependency script directly, use:

```bash
bash utils/dependencies.sh
```

### Build

```bash
xmake
```

### Run the bundled sample

```bash
xmake run
./samples/testing
```

`xmake run` builds the `adan` target and compiles `samples/testing.adn` by default.

## Useful XMake commands

```bash
$ xmake               # Build the ADAN compiler.
$ xmake run           # Build and run the default sample.
$ ./samples/testing   # Run the generated sample executable.
$ xmake format        # Format source files with clang-format.
$ xmake install       # Install required system dependencies.
$ xmake c             # Remove build artifacts.
$ xmake f -a x64      # Configure a target architecture.
```

## Compiler flags

```bash
adan -f <file.adn> [options]
```

| Flag | Description |
|------|-------------|
| `-f, --file <file>` | Source file to compile (`.adn` or `.adan`) |
| `-o, --output <path>` | Output path for the linked binary |
| `-r, --rawir` | Stop after emitting LLVM IR (`.ll`) |
| `-h, --help` | Show the help message and exit |

### Example

```bash
./build/linux/x86_64/release/adan -f main.adn -o main
```

If you prefer, you can also use the built compiler binary from the platform-specific `build` directory.