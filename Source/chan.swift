/*
* Chan (chan.swift) - Please be Safe
*
* Copyright (C) 2015 ONcast, LLC. All Rights Reserved.
* Created by Josh Baker (joshbaker77@gmail.com)
*
* This software may be modified and distributed under the terms
* of the MIT license.  See the LICENSE file for details.
*/

import Foundation

private let idMutex = Mutex()
private var idCounter = 0


/**
Channels are the pipes that connect concurrent operations. 
You can send values into channels from one operation and receive those values into another operation.

```
var messages = Chan<String>()
dispatch {
    messages <- "ping"
}
if let msg := <-messages {
    println(msg)
}
```


*/
public class Chan<T> : SequenceType {
    internal let id : Int
    internal let cap : Int
    internal let cond = Cond(Mutex())
    internal var msgs = [Any?]()
    internal var closed = false
    internal var gconds : [Cond] = []
    /// - Parameter capacity A value greater than Zero will create a buffered channel.
    /// - Returns a Chan object
    public init(_ capacity: Int = 0){
        cap = capacity
        idMutex.lock()
        idCounter += 1
        id = idCounter
        idMutex.unlock()
    }
    /// The number of elements queued (unread) in the channel buffer
    public func count() -> Int{
        if cap == 0 {
            return 0
        }
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        return msgs.count
    }
    /// The channel buffer capacity, in units of elements;
    public func capacity() -> Int{
        return cap
    }
    internal func broadcast() {
        cond.broadcast()
        for cond in gconds {
            cond.mutex.lock()
            cond.broadcast()
            cond.mutex.unlock()
        }
    }
    /**
    Closes the channel.
    It should be executed only by the sender, never the receiver, and has the effect of shutting down the channel after the last sent value is received. 
    After the last value has been received from a closed channel, any receive from the channel will succeed without blocking, returning the a nil value for the channel element.
    */
    public func close(){
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        closed = true
        broadcast()
    }
    internal func send(msg: T) {
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        if closed {
            assertionFailure("Send on closed channel")
            // NSException.raise("Exception", format: "send on closed channel", arguments: getVaList([]))
        }
        msgs.append(msg)
        broadcast()
        while msgs.count > cap {
            cond.wait()
        }
    }
    internal func receive(wait: Bool = true) -> (msg : T?, closed : Bool, ready : Bool) {
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        for ;; {
            if msgs.count > 0 {
                let msg = msgs.removeAtIndex(0)
                broadcast()
                return (msg as? T, false, true)
            }
            if closed {
                return (nil, true, true)
            }
            if !wait {
                return (nil, false, false)
            }
            cond.wait()
        }
    }
    public typealias Generator = AnyGenerator<T>
    public func generate() -> Generator {
        return AnyGenerator {
            return <-self
        }
    }
}

infix operator <- { associativity right precedence 155 }
prefix operator <- { }
/// Send a message over a channel. Sending over a closed channel will raise a runtime exception.
public func <-<T>(l: Chan<T>, r: T){
    l.send(r)
}
/// Receive a message over a channel. Returns nil if the channel is closed
public prefix func <-<T>(r: Chan<T>) -> T? {
    let (v, closed, _) = r.receive()
    if closed {
        return nil
    }
    return v!
}