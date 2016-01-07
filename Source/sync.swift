/*
* Sync (sync.swift) - Please be Safe
*
* Copyright (C) 2015 ONcast, LLC. All Rights Reserved.
* Created by Josh Baker (joshbaker77@gmail.com)
*
* This software may be modified and distributed under the terms
* of the MIT license.  See the LICENSE file for details.
*
* Portions of the documentation of this code are reproduced from 
* work created and shared by Google and used according to terms 
* described in the Creative Commons 3.0 Attribution License.
*
* http://golang.org/pkg/sync/
*/

#if os(Linux)
import Glibc
#endif

import Foundation

/// The WaitResult enum is used as a return value by Mutex.wait()
public enum WaitResult {
    /// The wait resulted in a signal
    case Signaled
    /// The wait resulted in a timeout
    case TimedOut
}

/// A Mutex is a mutual exclusion lock. 
public class Mutex {
    private var mutex = pthread_mutex_t()
    /// Returns a new Mutex.
    public init(){
        pthread_mutex_init(&mutex, nil)
    }
    deinit{
        pthread_mutex_destroy(&mutex)
    }
    /// Locks the mutex. If the lock is already in use, the calling operation blocks until the mutex is available.
    public func lock(){
        pthread_mutex_lock(&mutex)
    }
    /**
    Unlocks the mutex. It's an undefined error if mutex is not locked on entry to unlock.
    
    A locked Mutex is not associated with a particular operation. 
    It is allowed for one operation to lock a Mutex and then arrange for another operation to unlock it.
    */
    public func unlock(){
        pthread_mutex_unlock(&mutex)
    }
    
    /// Locks the mutex before calling the function. Unlocks after closure is completed
    /// - Parameter: closure Closure function
    public func lock(closure : ()->()) {
        lock()
        closure()
        unlock()
    }
}

/**
`Cond` implements a condition variable, a rendezvous point for an operation waiting for or announcing the occurrence of an event.

Each `Cond` has an associated `Mutex`, which must be held when changing the condition and when calling the `wait` method.
*/
public class Cond {
    private var cond = pthread_cond_t()
    public let mutex : Mutex
    ///  Returns a new Cond.
    /// - Parameter mutex: A Mutex object.
    public init(_ mutex : Mutex){
        self.mutex = mutex
        pthread_cond_init(&cond, nil)
    }
    deinit {
        pthread_cond_destroy(&cond)
    }
    /// Wakes all operations waiting on `Cond`.
    public func broadcast() {
        pthread_cond_broadcast(&cond)
    }
    /// Wakes one operations waiting on `Cond`.
    public func signal() {
        pthread_cond_signal(&cond)
    }
    /**

    Atomically unlocks `.mutex` and suspends execution of the calling operation.
    After later resuming execution, `waita locks `.mutex' before returning. 
    Unlike in other systems, `wait` cannot return unless awoken by `broadcast` or `signal', or the `timeout` param has been reached.
    
    Because `.mutex` is not locked when 'wait first resumes, the caller typically cannot assume that the condition is true when `wait` returns.
    Instead, the caller should `wait` in a loop:
    
    ```
    cond.mutex.lock()
    while !condition() {
        cond.mutex.wait()
    }
    ... make use of condition ...
    cond.mutex.unlock()
    ```
    */
    /// - Parameter timeout: The length of time to wait. Default is forever.
    /// - Returns: WaitResult
    public func wait(timeout : NSTimeInterval = -1) -> WaitResult {
        if timeout < 0 {
            pthread_cond_wait(&cond, &mutex.mutex)
            return .Signaled
        }
        let timeInMs = Int(timeout * 1000)
        var tv = timeval()
        var ts = timespec()
        gettimeofday(&tv, nil)
        ts.tv_sec = time(nil) + timeInMs / 1000
        let intermediate = 1000 * 1000 * (timeInMs % 1000)
        ts.tv_nsec = Int(tv.tv_usec * 1000 + intermediate)
        ts.tv_sec += ts.tv_nsec / 1000000000
        ts.tv_nsec %= 1000000000
        if (pthread_cond_timedwait(&cond, &mutex.mutex, &ts) == 0) {
            return .Signaled
        }
        return .TimedOut
    }
}

/// Once is an object that will perform exactly one action.
public class Once {
    private var mutex = Mutex()
    private var oncer = false
    ///  Returns a new Once.
    public init() {}
    /**
    Calls the `action` if and only if `doit` is being called for the first time for this instance of `Once`. In other words, given
    
    ```
    var once Once
    ```
        
    If `doit` is called multiple times, only the first call will invoke `action`, even if `action` has a different value in each invocation.
    A new instance of `Once` is required for each function to execute.
    
    This method is intended for initialization that must be run exactly once.
    */
    /// - Parameter action: An action function.
    public func doit(action: ()->()) {
        mutex.lock()
        defer { mutex.unlock() }
        if oncer{
            return
        }
        oncer = true
        action()
    }
}

/**
    A WaitGroup waits for a collection of operations to finish. 
    The main operation calls 'add' to set the number of operation to wait for.
    Then each of the operations runs and calls 'done' when finished.
    At the same time, 'wait' can be used to block until all operations have finished.
*/
public class WaitGroup {
    private var cond = Cond(Mutex())
    private var count = 0
    ///  Returns a new WaitGroup.
    public init() {}
    /**
    Adds delta, which may be negative, to the WaitGroup counter.
    If the counter becomes Zero, all operations blocked on 'wait' are released.
    If the counter goes negative, 'add' fires a system exception.
    
    Note that calls with a positive delta that occur when the counter is Zero must happen before a 'wait'.
    Calls with a negative delta, or calls with a positive delta that start when the counter is greater than zero, may happen at any time. 
    Typically this means the calls to 'add' should execute before the statement creating the operation or other event to be waited for.
    */
    public func add(delta: Int) {
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        count += delta
        if count < 0 {
            #if os(Linux)
            assertionFailure("negative WaitGroup counter")
            #else
            NSException.raise("Exception", format: "negative WaitGroup counter", arguments: getVaList([]))
            #endif
        }
        cond.broadcast()
    }
    /// Decrements the WaitGroup counter.
    public func done() {
        add(-1)
    }
    /// Blocks until the WaitGroup counter is Zero.
    public func wait() {
        cond.mutex.lock()
        defer { cond.mutex.unlock() }
        while count > 0 {
            cond.wait()
        }
        cond.mutex.unlock()
    }
}
