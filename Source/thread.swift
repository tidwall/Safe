/*
* Thread (thread.swift) - Please be Safe
*
* Copyright (C) 2015 ONcast, LLC. All Rights Reserved.
* Created by Josh Baker (joshbaker77@gmail.com)
*
* This software may be modified and distributed under the terms
* of the MIT license.  See the LICENSE file for details.
*/

import Foundation

private let pt_entry: @convention(c) (UnsafeMutablePointer<Void>) -> UnsafeMutablePointer<Void> = { (ctx) in
    let np = UnsafeMutablePointer<()->()>(ctx)
    np.memory()
    np.destroy()
    np.dealloc(1)
    return nil
}
public func dispatch(block : ()->()){
    let p = UnsafeMutablePointer<()->()>.alloc(1)
    p.initialize(block)
    var t = pthread_t()
    pthread_create(&t, nil, pt_entry, p)
    pthread_detach(t)
}
