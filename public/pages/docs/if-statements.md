
## If Statements

If statements let you run code only when a condition is true. The basic syntax is:

```adan
if <condition> {
    // Code to run if condition is true
}
```

### Example

```adan
set x: i32 = 5;
if x > 0 {
    println("x is positive");
}
```

### Logical and Comparison Operators

You can use these operators in conditions:

- `and`, `or`, `not` (logical)
- `>=`, `<=`, `==`, `!=`, `<`, `>` (comparison)

#### Example with Operators

```adan
set x: i32 = 7;
set y: i32 = 3;
if x > 0 and y < 10 {
    println("x is positive and y is less than 10");
}

set done: bool = false;
if not done {
    println("Not done yet!");
}
```

### Block Scope

Variables declared inside an if block are only available in that block:

```adan
if true {
    set message: string = "Hello!";
    println(message);
}

// Message is not accessible here
```

### Notes
- The condition goes after `if` and before `{`.
- The code inside `{ ... }` runs only if the condition is true.
