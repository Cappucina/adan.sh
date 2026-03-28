## Type Aliases

Use `type` to give a reusable name to an existing type.

### Basic syntax

```adan
type Name = ExistingType;
```

### Aliasing object shapes

```adan
type User = { name: string, age: i32 };

set current: User = {
    name: "Ada",
    age: 21
};
```

### Aliasing arrays

```adan
type Scores = i32[];

set run: Scores = [100, 98, 95];
```

### Combining aliases

```adan
type User = { name: string, age: i32 };
type Team = User[];

set members: Team = [
    {
        name: "Ada",
        age: 21
    },
    {
        name: "Grace",
        age: 22
    }
];
```

### Why aliases help

Aliases make complex types easier to read, reuse, and update.

They are especially useful for:

- object-heavy code
- nested arrays
- shared function parameter types
- shared return types