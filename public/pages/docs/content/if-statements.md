
## If Statements

Use `if` to run code only when a condition is true.

### Basic form

```adan
if score > 0 {
    score--;
}
```

### `else` and `else if`

```adan
if health <= 0 {
    state = "lost";
}
else if health < 25 {
    state = "danger";
}
else {
    state = "safe";
}
```

### Conditions

Conditions are normal expressions, usually built from comparison and logical operators.

```adan
if level >= 10 and not finished {
    reward = 1;
}
```

### Example with output

```adan
import "adan/io";

function main(): i32 {
    set age: i32 = 21;

    if age >= 18 {
        print("adult");
    }
    else {
        print("minor");
    }

    return 0;
}
```

### Notes

- Braces are used for each branch.
- `else if` is supported directly.
- Variables declared inside a branch stay inside that branch.
