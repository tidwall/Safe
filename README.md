<p align="center">
  <img src="http://tidwall.github.io/Safe/head.png" width="424" height="155">
  <br>
  <a href="https://tidwall.github.io/Safe/test-results.txt"><img src="https://tidwall.github.io/Safe/build.png" alt="" width="93" height="20" border="0" /></a>
  <a href="https://developer.apple.com/swift/"><img src="https://tidwall.github.io/Safe/swift2.png" alt="" width="65" height="20" border="0" /></a>
</p>

##Features

- Simple `Atomic<T>` class for numbers and strings.
- Uncomplicated `dispatch` keyword for firing off background routines.
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

Safe adds an uncomplicated method for dispatching routines. 

```swift
dispatch {
    print("Background")
}
print("Foreground")
```

## Channels

A new `Chan<T>` class provides a clean and simple model for concurrently sharing objects. `Chan<T>` is modeled after [Go channels](https://golang.org/doc/effective_go.html#channels).

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
```

#### Select

The `_select` keyword is a multiway communications multiplexer that works on multiple channels.  `_select`, `_case`, and `_default` start with underscores so that they do not conflict with the `select`, `case`, and `default` syscall and keywords.

```swift
let jobs1 = Chan<Int>()
let jobs2 = Chan<Int>()

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

#### Select with Default

A `_select` can contain a single `_default` for non-blocking operations. 

```swift
_select {
    _case(jobs1){ j in
        print("received 1: \(j)")
    }
    _case(jobs2){ j in
        print("received 2: \(j)")
    }
    _default {
        print("channels not ready")
    }
}
```

## Mutex, Cond, Once, WaitGroup

Incredibly useful sync APIs.

#### Mutex

```swift
let m = Mutex()
m.lock()           
m.unlock()         
m.lock {
    // this block is locked
}
```
#### Cond
```swift
let c = Cond(Mutex())
c.wait()                // wait for signal.
c.wait(0.25)            // wait for signal or 250ms to pass.
c.signal()              // signal to one wait.
c.broadcast()           // signal to all waits.
```
#### Once
```swift
func f(){
    print("hey there")
}

let o = Once()
o.doit(f)               // runs once
o.doit(f)               // noop: cannot run twice
```
#### WaitGroup
```swift
let dosomething : (NSTimeInterval, WaitGroup)->() = { (delay, wg) in
    NSThread.sleepForTimeInterval(delay)
    print("Function in background, duration: \(delay)")
    wg.done()
}
let wg = WaitGroup()
wg.add(1)
dispatch { dosomething(0.40, wg) }
wg.add(1)
dispatch { dosomething(0.30, wg) }
wg.add(1)
dispatch { dosomething(0.15, wg) }
wg.add(1)
dispatch { dosomething(0.60, wg) }
wg.wait()
print("done")
```

##Installation (iOS and OS X)

### [Carthage]

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your Cartfile:

```
github "tidwall/Safe"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

The `import Safe` directive is required in order to access Safe features.

### [CocoaPods]

[CocoaPods]: http://cocoapods.org

Add the following to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html):

```ruby
use_frameworks!
pod 'Safe'
```

Then run `pod install` with CocoaPods 0.36 or newer.

The `import Safe` directive is required in order to access Safe features.

###Manually

Copy the `Source/*.swift` file into your project.  

There is no need for `import Safe` when manually installing.

## Contact
Josh Baker [@tidwall](http://twitter.com/tidwall)

## License

The Safe source code is available under the MIT License.

