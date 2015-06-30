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

public class Chan<T> : SequenceType {
    internal let id : Int
    internal let cap : Int
    internal let cond = Cond(Mutex())
    internal var msgs = [Any?]()
    internal var closed = false
    internal var gconds : [Cond] = []
    public init(_ capacity: Int = 0){
        cap = capacity
        idMutex.lock()
        id = ++idCounter
        idMutex.unlock()
    }
    public func count() -> Int{
        if cap == 0 {
            return 0
        }
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        return msgs.count
    }
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
    public func close(){
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        closed = true
        broadcast()
    }
    public func send(msg: T) {
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        if closed {
            fatalError("send on closed channel")
        }
        msgs.append(msg)
        broadcast()
        while msgs.count > cap {
            cond.wait()
        }
    }
    public func receive(wait: Bool = true) -> (msg : T?, closed : Bool, ready : Bool) {
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        for ;; {
            if closed {
                return (nil, true, true)
            }
            if msgs.count > 0 {
                let msg = msgs.removeAtIndex(0)
                broadcast()
                return (msg as? T, false, true)
            }
            if !wait {
                return (nil, false, false)
            }
            cond.wait()
        }
    }
    typealias Generator = AnyGenerator<T>
    public func generate() -> Generator {
        return anyGenerator {
            return <-self
        }
    }
}

infix operator <- { associativity right precedence 155 }
prefix operator <- { }
public func <-<T>(l: Chan<T>, r: T){
    l.send(r)
}
public prefix func <-<T>(r: Chan<T>) -> T? {
    let (v, closed, _) = r.receive()
    if closed {
        return nil
    }
    return v!
}