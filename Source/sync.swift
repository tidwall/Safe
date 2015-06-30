/*
* Sync (sync.swift) - Please be Safe
*
* Copyright (C) 2015 ONcast, LLC. All Rights Reserved.
* Created by Josh Baker (joshbaker77@gmail.com)
*
* This software may be modified and distributed under the terms
* of the MIT license.  See the LICENSE file for details.
*/

import Foundation

public enum WaitResult {
    case Signaled
    case TimedOut
}

public class Mutex {
    private var mutex = pthread_mutex_t()
    public init(){
        pthread_mutex_init(&mutex, nil)
    }
    deinit{
        pthread_mutex_destroy(&mutex)
    }
    public func lock(){
        pthread_mutex_lock(&mutex)
    }
    public func unlock(){
        pthread_mutex_unlock(&mutex)
    }
    public func lock(closure : ()->()){
        lock()
        closure()
        unlock()
    }
}
public class Cond {
    private var cond = pthread_cond_t()
    public let mutex : Mutex
    public init(_ mutex : Mutex){
        self.mutex = mutex
        pthread_cond_init(&cond, nil)
    }
    deinit {
        pthread_cond_destroy(&cond)
    }
    public func broadcast(){
        pthread_cond_broadcast(&cond)
    }
    public func signal(){
        pthread_cond_signal(&cond)
    }
    public func wait() -> WaitResult {
        pthread_cond_wait(&cond, &mutex.mutex)
        return .Signaled
    }
    public func wait(timeout : NSTimeInterval) -> WaitResult {
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
        } else {
            return .TimedOut
        }
    }
}
public class Once {
    private var mutex = Mutex()
    private var oncer = false
    func doit(closure:()->()){
        mutex.lock()
        if oncer{
            mutex.unlock()
            return
        }
        oncer = true
        closure()
        mutex.unlock()
    }
}
public class WaitGroup {
    private var cond = Cond(Mutex())
    private var count = 0
    func add(delta : Int){
        cond.mutex.lock()
        count += delta
        if count < 0 {
            fatalError("sync: negative WaitGroup counter")
        }
        cond.broadcast()
        cond.mutex.unlock()
    }
    func done(){
        add(-1)
    }
    func wait(){
        cond.mutex.lock()
        while count > 0 {
            cond.wait()
        }
        cond.mutex.unlock()
    }
}
