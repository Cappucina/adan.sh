## Arrays

Arrays store ordered collections of values.

### Array types

Write an array type by adding `[]` after another type.

```adan
set numbers: i32[] = [1, 2, 3];
set names: string[] = ["Ada", "Grace"];
set grid: i32[][] = [[1, 2], [3, 4]];
```

### Indexing

Use `[]` to read an item by index.

```adan
set numbers: i32[] = [10, 20, 30];
set first: i32 = numbers[0];
```

### Array methods

ADAN supports these built-in array methods:

- `push(value)`
- `pop()`
- `insert(index, value)`
- `remove(index)`
- `slice(start)`
- `slice(start, end)`
- `clear()`
- `length()`
- `len()`

### Examples

```adan
set values: i32[] = [1, 2, 3];

values.push(4);
values.insert(1, 99);

set removed: i32 = values.remove(2);
set last: i32 = values.pop();
set count: i32 = values.length();

set part: i32[] = values.slice(0, 2);
```

### Notes

- Array literals use square brackets.
- `length()` and `len()` both return the current size.
- `slice(start)` runs to the end of the array.
- Element access uses zero-based indexing.