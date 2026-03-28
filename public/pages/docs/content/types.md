## Types

ADAN is statically typed. Variable declarations, parameters, and return values all use explicit types.

### Primitive types

ADAN currently supports these built-in primitive types:

| Type | Description |
|------|-------------|
| `bool` | Boolean values: `true` or `false` |
| `string` | Text data |
| `i8` | 8-bit signed integer |
| `u8` | 8-bit unsigned integer |
| `i32` | 32-bit signed integer |
| `u32` | 32-bit unsigned integer |
| `i64` | 64-bit signed integer |
| `u64` | 64-bit unsigned integer |
| `f32` | 32-bit floating-point number |
| `f64` | 64-bit floating-point number |
| `void` | No return value |
| `any` | A flexible type used typically with ellipsis |

### Examples

```adan
set age: i32 = 21;
set distance: f64 = 12.5;
set name: string = "Ada";
set ready: bool = true;
```

### Composite types

ADAN also supports array and object-shaped types.

```adan
set scores: i32[] = [10, 20, 30];
set user: { name: string, age: i32 } = {
    name: "Ada",
    age: 21
};
```

### Function return types

Every function declares a return type.

```adan
function greet(): void {
    return;
}

function square(n: i32): i32 {
    return n * n;
}
```

### Type casting

Use `(<type>)<expression>` for an explicit cast.

```adan
set raw: string = "42";
set value: i32 = (i32)raw;

set ratioText: string = "3.5";
set ratio: f64 = (f64)ratioText;
```

### Notes

- Integer literals default to `i32`.
- Decimal literals default to `f64`.
- Casts are most useful when converting between strings and numbers.
- Reusable custom types are covered in the type-alias guide.