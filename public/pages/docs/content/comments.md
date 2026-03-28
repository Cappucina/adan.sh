## Comments

Comments are ignored by the compiler and are only there for humans reading your code.

### Single-line comments

Use `//` to comment out the rest of a line.

```adan
// This whole line is ignored.
set answer: i32 = 42; // This part is ignored too.
```

### Block comments

Use `/*` and `*/` for longer notes.

```adan
/*
    ADAN ignores everything in this block.
    This is useful for longer explanations.
*/

set enabled: bool = true;
```

### Example

```adan
function add(a: i32, b: i32): i32 {
    // Return the sum.
    return a + b;
}
```

### Notes

- Prefer short comments that explain *why* the code exists.
- Inline comments are fine when they add clarity.
- Block comments should not be nested.