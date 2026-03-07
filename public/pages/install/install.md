## Build the Compiler from [Source](https://github.com/Cappucina/ADAN)

> It's highly recommended to use a mainstream Linux distribution such as Ubuntu, Fedora, or Arch Linux when compiling the ADAN compiler yourself.

### Clone the repository

```bash
git clone https://github.com/Cappucina/ADAN.git
cd ADAN
```

### Install dependencies

Run the dependency script before compiling manually.

```bash
chmod +x ./dependencies.sh
./dependencies.sh
```

### Compile with Make

```bash
make
```


## Useful Make Commands

```bash
make         # Clean, build, and run the binary
make build   # Clean and create a fresh binary
make run     # Clear terminal and run an existing binary
make format  # Format C files in ./src using .clang-format
make clean   # Remove existing binary in ./build
make install # Install required dependencies (Linux only)
```


## Compiler Flags

```bash
adan -f <file.adn> [options]
```

| Flag | Description |
|------|-------------|
| `-f, --file <file>` | Source file to compile (`.adn` or `.adan` extension required) |
| `-o, --output <path>` | Output path for the linked binary. If `<path>` is a directory, the binary is placed inside it named after the source file |
| `--link` | Link the compiled IR into an executable |
| `--libs <libs>` | Comma-separated list of extra libraries to link against |
| `--bundle-runtime` | Bundle the built-in runtime (`adan/io`) into the binary |
| `--bundle-embedded <mods>` | Bundle specific embedded modules into the binary (comma-separated) |
| `--bundle-libs <libs>` | Bundle external libraries into the binary |
| `-h, --help` | Show the help message and exit |

### Examples

Compile a source file to LLVM IR:

```bash
adan -f main.adn
```

Compile and link into an executable:

```bash
adan -f main.adn --link
```

Compile, link, and specify an output path:

```bash
adan -f main.adn --link -o ./build/myprogram
```

Link against external libraries:

```bash
adan -f main.adn --link --libs mylib,otherlib
```

Bundle the runtime and link:

```bash
adan -f main.adn --link --bundle-runtime
```
