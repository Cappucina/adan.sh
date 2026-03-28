## Loops

ADAN supports `while` loops and C-style `for` loops.

### `while`

Use `while` when you want to repeat code until a condition becomes false.

```adan
set count: i32 = 0;

while count < 3 {
    count++;
}
```

### `for`

ADAN `for` loops use four parts:

1. An initial variable declaration
2. A loop condition
3. An increment step
4. A loop body

```adan
for set i: i32 = 0; i < 5; i++ {
    // loop body
}
```

The increment step can use several forms:

```adan
for set i: i32 = 0; i < 10; i = i + 1 {
}

for set i: i32 = 0; i < 10; i += 1 {
}

for set i: i32 = 10; i > 0; i-- {
}
```

### `break` and `continue`

Use `break;` to leave a loop early.

Use `continue;` to skip to the next iteration.

```adan
for set i: i32 = 0; i < 10; i++ {
    if i == 3 {
        continue;
    }

    if i == 8 {
        break;
    }
}
```

### Example

```adan
import "adan/io";

function main(): i32 {
    for set i: i32 = 0; i < 3; i++ {
        print("i = %d", i);
    }

    return 0;
}
```