<p align="center">
  <img src="http://tidwall.github.io/Safe/head.png" width="500" height="155">
</p>

##Features

- Simple `Atomic<T>` class for numbers and strings.
- Uncomplicated `dispatch` keyword for firing off new threads.
- Awesome `Chan<T>` for conncurent communication.
- Useful sync APIs. `Mutex`, `Cond`, `Once`, `WaitGroup`


## Atomic

#### Types
`Int`, `Int8`, `Int16`, `Int32`, `Int64`, `UInt`, `UInt8`, `UInt16`, `UInt32`, `UInt64`, `Float`, `Double`, `Bool`, `String`

#### Operators
- `==`, `!=`, `&&`, `||`, `<=`, `>=`, `>`, `<`, `!`  
- `+`, `-`, `*`, `/`, `%`, `<<`, `>>`, `^`, `&`, `&+`, `&-`, `&*`, `++`, `--`, `+=`, `-=`, `*=`, `/=`, `%=`, `+=`, `<<=`, `>>=`, `^=`, `&=`


```swift
var anum = IntA(100)      // IntA is an alias for Atomic<Int>.
anum += 15                // Adds a value atomically.
let res = anum % 4        // Modulo operation atomically.
print("\(anum) \(res)")   // prints '115 3'.
```

## Dispatch

Safe adds an uncomplicated method for dispatching threads. 

```swift
dispatch {
    print("Background")
}
print("Foreground")
```

## Channels

A new `Chan<T>` class provides a clean and simple model for concurrently sharing objects. `Chan<T>` is strictly modeled after [Go channels](https://golang.org/doc/effective_go.html#channels).

[Sharing Memory by Communicating](http://blog.golang.org/share-memory-by-communicating)

#### Example
```swift
let jobs = Chan<Int>(5)  // buffered channel
let done = Chan<Bool>()  // unbuffered channel

dispatch {
    for ;; {
        if let j = <-jobs {
            print("received job \(j)")
        } else {
            print("received all jobs")
            done <- true
            return
        }
    }
}

for var j = 1; j <= 3; j++ {
    jobs <- j
    print("sent job \(j)")
}
jobs.close()
print("sent all jobs")

<-done
```

#### Iterate

A channel can also be iterated through.

```swift
while let j = <-jobs {
    print("received job \(j)")
}
print("received all jobs")
done <- true
```

#### Select

The `select` keyword is a multiway communications multiplexer that works on multiple channels. 

```swift
let jobs1 = Chan<Int>()  // buffered channel
let jobs2 = Chan<Int>()  // buffered channel

dispatch {
    for ;; {
        _select {
            _case(jobs1){ j in
                print("received 1: \(j)")
            }
            _case(jobs2){ j in
                print("received 2: \(j)")
            }
        }
    }
}

for var j = 1; ; j++ {
    jobs1 <- (j * 1000)
    jobs2 <- (j * 2000)
    NSThread.sleepForTimeInterval(1)
}
```




