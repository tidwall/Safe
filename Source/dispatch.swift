/*
* Dispatch (dispatch.swift) - Please be Safe
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
* http://golang.org/ref/spec
*/

#if os(Linux)
import Glibc
#endif

import Foundation

private let pt_entry: @convention(c) (UnsafeMutablePointer<Void>) -> UnsafeMutablePointer<Void> = { (ctx) in
    let np = UnsafeMutablePointer<()->()>(ctx)
    np.memory()
    np.destroy()
    np.dealloc(1)
    return nil
}

/// A `dispatch` statement starts the execution of an action as an independent concurrent thread of control within the same address space.
public func dispatch(action: ()->()){
    let p = UnsafeMutablePointer<()->()>.alloc(1)
    p.initialize(action)
    var t : pthread_t = nil
    pthread_create(&t, nil, pt_entry, p)
    pthread_detach(t)
}



