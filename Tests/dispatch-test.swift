//
//  dispatch-test.swift
//  Safe
//
//  Created by Josh Baker on 7/1/15.
//  Copyright © 2015 ONcast. All rights reserved.
//


import XCTest

extension Tests {
    func _testDispatch(count: Int){
        var total = 0
        let xtotal = makeTotal(count)
        let wg = WaitGroup()
        let mutex = Mutex()
        wg.add(count)
        for var i = 0; i < count; i++ {
            { i in
                dispatch {
                    mutex.lock()
                    total += i
                    mutex.unlock()
                    wg.done()
                }
                }(i)
        }
        wg.wait()
        XCTAssert(xtotal == total, "The expected total is incorrect.")
    }
    func testDispatchTen() {
        _testDispatch(10)
    }
    func testDispatchHundred() {
        _testDispatch(100)
    }
}
