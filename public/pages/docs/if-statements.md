# If Statements

Conditional execution in adan.sh uses the `if` statement. The syntax is:

```
if <condition> {
    ...
}
```

## Example

```
if x > 0 {
    println("x is positive")
}
```

## Supported Operators

- `and`, `or`, `not` (logical operators)
- `>=`, `<=`, `==`, `!=`, `<`, `>` (comparison operators)

### Example with logical operators

```
if x > 0 and y < 10 {
    println("x is positive and y is less than 10")
}

if not done {
    println("Not done yet!")
}
```

## Notes
- The condition must be inside the parentheses after `if` and before the opening `{`.
- The block inside `{ ... }` is executed only if the condition is true.
