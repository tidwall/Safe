/*
* Atomic (atomic.swift) - Please be Safe
*
* Copyright (C) 2015 ONcast, LLC. All Rights Reserved.
* Created by Josh Baker (joshbaker77@gmail.com)
*
* This software may be modified and distributed under the terms
* of the MIT license.  See the LICENSE file for details.
*/

import Foundation

/** 
Atomic is a class that allows for atomic loading and storing of objects.atomic

```
var ai = Atomic<Int>(15)
ai += 10
print(ai) // prints 25
```

There are a number of helper aliases for common types such as IntA, StringA, BoolA

```
var ai = IntA(15)
ai += 10
print(ai) // prints 25
```

*/
public class Atomic<T> : CustomStringConvertible {
    private var mutex = Mutex()
    private var value : T
    /// Returns an atomic object.
    public init(_ value : T) {
        self.value = value
    }
    /// Loads the value atomically.
    public func load() -> T {
        mutex.lock()
        defer { mutex.unlock() }
        return value
    }
    /// Stores a value atomically.
    public func store(value : T) {
        mutex.lock()
        defer { mutex.unlock() }
        self.value = value
    }
    /// Exchanges / Swaps values atomically.
    public func exchange(atomic : Atomic<T>) {
        atomic.mutex.lock()
        defer { atomic.mutex.unlock() }
        mutex.lock()
        defer { mutex.unlock() }
        let temp = value
        value = atomic.value
        atomic.value = temp
    }
    public var description : String {
        mutex.lock()
        defer { mutex.unlock() }
        return "\(value)"
    }
}

@inline(__always) private func lock<T>(lhs: Atomic<T>, _ rhs: Atomic<T>){
    lhs.mutex.lock()
    if lhs !== rhs { rhs.mutex.lock() }
}
@inline(__always) private func lock<T>(lhs: Atomic<T>){
    lhs.mutex.lock()
}
@inline(__always) private func unlock<T>(lhs: Atomic<T>, _ rhs: Atomic<T>){
    lhs.mutex.unlock()
    if lhs !== rhs { rhs.mutex.unlock() }
}
@inline(__always) private func unlock<T>(lhs: Atomic<T>){
    lhs.mutex.unlock()
}


public func ==<T : Equatable>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value == rhs.value; unlock(lhs, rhs); return result }
public func ==<T : Equatable>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs == rhs.value; unlock(rhs); return result }
public func ==<T : Equatable>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value == rhs; unlock(lhs); return result }
public func !=<T : Equatable>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value != rhs.value; unlock(lhs, rhs); return result }
public func !=<T : Equatable>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs != rhs.value; unlock(rhs); return result }
public func !=<T : Equatable>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value != rhs; unlock(lhs); return result }
public func &&<T : BooleanType>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value && rhs.value; unlock(lhs, rhs); return result }
public func &&<T : BooleanType>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs && rhs.value; unlock(rhs); return result }
public func &&<T : BooleanType>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value && rhs; unlock(lhs); return result }
public func ||<T : BooleanType>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value || rhs.value; unlock(lhs, rhs); return result }
public func ||<T : BooleanType>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs || rhs.value; unlock(rhs); return result }
public func ||<T : BooleanType>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value || rhs; unlock(lhs); return result }
public func <=<T : Comparable>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value <= rhs.value; unlock(lhs, rhs); return result }
public func <=<T : Comparable>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs <= rhs.value; unlock(rhs); return result }
public func <=<T : Comparable>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value <= rhs; unlock(lhs); return result }
public func >=<T : Comparable>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value >= rhs.value; unlock(lhs, rhs); return result }
public func >=<T : Comparable>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs >= rhs.value; unlock(rhs); return result }
public func >=<T : Comparable>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value >= rhs; unlock(lhs); return result }
public func ><T : Comparable>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value > rhs.value; unlock(lhs, rhs); return result }
public func ><T : Comparable>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs > rhs.value; unlock(rhs); return result }
public func ><T : Comparable>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value > rhs; unlock(lhs); return result }
public func <<T : Comparable>(lhs: Atomic<T>, rhs: Atomic<T>) -> Bool { lock(lhs, rhs); let result = lhs.value < rhs.value; unlock(lhs, rhs); return result }
public func <<T : Comparable>(lhs: T, rhs: Atomic<T>) -> Bool { lock(rhs); let result = lhs < rhs.value; unlock(rhs); return result }
public func <<T : Comparable>(lhs: Atomic<T>, rhs: T) -> Bool { lock(lhs); let result = lhs.value < rhs; unlock(lhs); return result }
public prefix func !<T : BooleanType>(x: Atomic<T>) -> Atomic<Bool> { lock(x); let result = !x.value; unlock(x); return Atomic(result) }

// TEMPLATE: typealias
public typealias {{O}} = Atomic<{{T}}>

// TEMPLATE: initialize-head
public extension {{T}} {
// TEMPLATE: initialize-body
public init (_ atomic : Atomic<{{O}}>){ self = {{T}}(atomic.load()) }
// TEMPLATE: initialize-foot
}

// TEMPLATE: arithmetic
public func {{O}}(lhs: Atomic<{{T}}>, rhs: Atomic<{{T}}>) -> Atomic<{{T}}> { lock(lhs, rhs); let result = lhs.value {{O}} rhs.value; unlock(lhs, rhs); return Atomic(result) }
public func {{O}}(lhs: {{T}}, rhs: Atomic<{{T}}>) -> Atomic<{{T}}> { lock(rhs); let result = lhs {{O}} rhs.value; unlock(rhs); return Atomic(result) }
public func {{O}}(lhs: Atomic<{{T}}>, rhs: {{T}}) -> Atomic<{{T}}> { lock(lhs); let result = lhs.value {{O}} rhs; unlock(lhs); return Atomic(result) }

// TEMPLATE: modify
public func {{O}}(lhs: Atomic<{{T}}>, rhs: Atomic<{{T}}>) { lock(lhs, rhs); lhs.value {{O}} rhs.value; unlock(lhs, rhs) }
public func {{O}}(inout lhs: {{T}}, rhs: Atomic<{{T}}>) { lock(rhs); lhs {{O}} rhs.value; unlock(rhs) }
public func {{O}}(lhs: Atomic<{{T}}>, rhs: {{T}}) { lock(lhs); lhs.value {{O}} rhs; unlock(lhs) }

// TEMPLATE: prefix
public prefix func {{O}}(x: Atomic<{{T}}>) -> Atomic<{{T}}> { lock(x); let result = {{O}}x.value; unlock(x); return Atomic(result) }

// TEMPLATE: postfix
public postfix func {{O}}(x: Atomic<{{T}}>) -> Atomic<{{T}}> { lock(x); let result = x.value{{O}}; unlock(x); return Atomic(result) }
