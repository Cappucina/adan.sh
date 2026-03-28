## Imports and Standard I/O

Import standard modules with the `import` keyword.

```adan
import "adan/io";
```

The `adan/io` module exposes the most common console helpers.

### `print(format: string, ...args: any): void`

Prints a formatted line to standard output.

```adan
import "adan/io";

function main(): i32 {
	print("Hello, world!");
	print("Player %s has %d points", "Ada", 120);
	
    return 0;
}
```

### `input(prompt: string): string`

Shows a prompt and returns the entered text.

```adan
import "adan/io";

function main(): i32 {
	set name: string = input("What is your name? ");
	print("Hello, %s!", name);
	
    return 0;
}
```

### `error(format: string, ...args: any): void`

Prints an error message and terminates execution.

```adan
import "adan/io";

function main(): i32 {
	error("Fatal: %s", "missing configuration"); // Returns 1 in itself
	
    return 0;
}
```

### Format specifiers

`print()` and `error()` use the same formatter as `string.format()`.

- `%s` string
- `%d` or `%i` integer
- `%u` unsigned integer
- `%f` floating-point number
- `%c` character
- `%p` pointer-like value
- `%%` literal percent sign

### Notes

- All core library paths use the `adan/...` prefix.