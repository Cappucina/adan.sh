## Functions

Functions are declared with the `function` keyword.

### Basic syntax

```adan
function name(params): returnType {
    return value;
}
```

### Declaring functions

```adan
function greet(): void {
    return;
}

function square(n: i32): i32 {
    return n * n;
}
```

### Parameters

Every parameter needs a name and a type.

```adan
function add(a: i32, b: i32): i32 {
    return a + b;
}
```

### Variadic parameters

ADAN supports variadic parameters with `...`.

```adan
function debug(label: string, ...values: any): void {
    return;
}
```

This is how the standard `print()` and `error()` helpers accept extra arguments.

### Calling functions

```adan
function add(a: i32, b: i32): i32 {
    return a + b;
}

function main(): i32 {
    set result: i32 = add(3, 7);
    return result;
}
```

### Recursion

```adan
function factorial(n: i32): i32 {
    if n <= 1 {
        return 1;
    }

    return n * factorial(n - 1);
}
```

### Notes

- Return types are always explicit.
- Use `void` when no value is returned.
- `return;` is valid in `void` functions.