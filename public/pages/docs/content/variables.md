## Variables and Constants

ADAN uses `set` for mutable variables and `const` for immutable values.

### Mutable variables

Declare a mutable variable with a name, a type, and an initializer.

```adan
set score: i32 = 100;
set username: string = "player1";
set active: bool = true;
```

### Constants

Use `const` when a value should not change after it is created.

```adan
const maxPlayers: i32 = 4;
const appName: string = "ADAN Demo";
```

### Reassignment

Mutable variables can be updated after declaration.

```adan
set total: i32 = 10;

total = 12;
total += 5;
total -= 2;
total *= 3;
total /= 5;
total++;
total--;
```

Trying to assign to a `const` value is a semantic error.

### Naming rules

- Names can start with a letter or `_`.
- Digits are allowed after the first character.
- Names are case-sensitive.

```adan
set _private: i32 = 0;
set playerName: string = "Ada";
set value2: f64 = 3.5;
```

### Scope

Variables live inside the block where they are declared.

```adan
function main(): i32 {
    set result: i32 = 0;

    if true {
        set inner: i32 = 10;
        result = inner;
    }

    return result;
}
```

### Notes

- Declarations require an explicit type.
- The first assignment usually happens in the declaration itself.
- Use `const` by default, and switch to `set` when mutation is necessary.