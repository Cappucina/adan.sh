
## Strings

Strings represent text in ADAN.

### Creating strings

You can write string literals with double quotes, single quotes, or backticks.

```adan
set a: string = "Hello";
set b: string = 'World';
set c: string = `ADAN`;
```

### Concatenation

Use `+` to join strings together.

```adan
set first: string = "Hello, ";
set second: string = "Ada";
set message: string = first + second;
```

### Interpolation

ADAN supports `${...}` interpolation inside string literals.

```adan
set name: string = "Ada";
set age: i32 = 21;
set info: string = `Name: ${name}, Age: ${age}`;
```

Expressions work too:

```adan
set a: i32 = 5;
set b: i32 = 3;
set sumText: string = `Sum: ${a + b}`;
```

### Formatting with `.format()`

Strings also support a formatting method.

```adan
set name: string = "Ada";
set score: i32 = 98;
set line: string = "Player %s scored %d".format(name, score);
```

Common format specifiers include:

- `%s` for strings
- `%d` or `%i` for integers
- `%u` for unsigned values
- `%f` for floating-point values
- `%c` for a character
- `%p` for a pointer-like value
- `%%` for a literal percent sign

### Example

```adan
set who: string = "Ada";
set greeting: string = `Hi, ${who}!`;
set message: string = greeting + " Welcome back.";
```