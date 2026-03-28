## Operators

ADAN supports arithmetic, comparison, and logical operators.

### Arithmetic operators

```adan
set add: i32 = 10 + 5;
set sub: i32 = 10 - 5;
set mul: i32 = 10 * 5;
set div: i32 = 10 / 5;
set mod: i32 = 10 % 3;
set pow: i32 = 2 ^ 8;
```

### Comparison operators

Comparison operators return a boolean value.

```adan
set same: bool = 10 == 10;
set different: bool = 10 != 5;
set smaller: bool = 3 < 7;
set larger: bool = 9 > 4;
set atMost: bool = 5 <= 5;
set atLeast: bool = 8 >= 3;
```

### Logical operators

Use `and`, `or`, and `not` in conditions.

```adan
set online: bool = true;
set admin: bool = false;

set canView: bool = online and not admin;
set fallback: bool = admin or online;
```

### String concatenation

`+` also joins strings.

```adan
set label: string = "Hello, " + "world!";
```

### Operator precedence

Exponentiation binds tightly, then `*`, `/`, and `%`, then `+` and `-`.

```adan
set a: i32 = 2 + 3 * 4;      // 14
set b: i32 = (2 + 3) * 4;    // 20
set c: i32 = 2 ^ 3 ^ 2;
```

Use parentheses when you want to make evaluation order obvious.
