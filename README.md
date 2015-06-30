<p align="center">
  <img src="http://tidwall.github.io/Safe/head.png" width="500" height="155">
</p>

##Features

- Simple `Atomic<T>` class for numbers and strings.
- Uncomplicated `dispatch` keyword for firing off new threads.
- Awesome `Chan<T>` for conncurent communication.
- Useful sync APIs. `Mutex`, `Cond`, `Once`, `WaitGroup`


## Atomic



##### Types
`Int`, `Int8`, `Int16`, `Int32`, `Int64`, `UInt`, `UInt8`, `UInt16`, `UInt32`, `UInt64`, `Float`, `Double`, `Bool`, `String`.

##### Operators
- `==`, `!=`, `&&`, `||`, `<=`, `>=`, `>`, `<`, `!`  
- `+`, `-`, `*`, `/`, `%`, `<<`, `>>`, `^`, `&`, `&+`, `&-`, `&*`, `++`, `--`, `+=`, `-=`, `*=`, `/=`, `%=`, `+=`, `<<=`, `>>=`, `^=`, `&=`


```swift
var anum = IntA(100)      // IntA is an alias for Atomic<Int>.
anum += 15                // Adds a value atomically.
let res = anum % 4        // Modulo operation atomically.
print("\(anum) \(res)")   // prints '115 3'.
```
