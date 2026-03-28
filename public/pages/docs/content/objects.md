## Objects

Objects store named properties.

### Object literals

Object literal keys are written as identifiers.

```adan
set user: { name: string, age: i32 } = {
    name: "Ada",
    age: 21
};
```

### Object types

Object types describe the shape of an object.

```adan
set config: {
    host: string,
    port: i32,
    secure: bool
} = {
    host: "localhost",
    port: 8080,
    secure: false
};
```

### Property access

Use `.` to access a property.

```adan
set username: string = user.name;
set years: i32 = user.age;
```

### Nested values

Objects and arrays can be nested.

```adan
set player: {
    name: string,
    scores: i32[],
    profile: {online: bool}
} = {
    name: "Ada",
    scores: [10, 20, 30],
    profile: {online: true}
};

set top: i32 = player.scores[0];
set online: bool = player.profile.online;
```

### Notes

- Object properties are checked against the declared type.
- Accessing an unknown property is a semantic error.
- If you reuse the same object shape often, create a type alias.