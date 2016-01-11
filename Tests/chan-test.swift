//
//  chan-test.swift
//  Safe
//
//  Created by Josh Baker on 7/2/15.
//  Copyright © 2015 ONcast. All rights reserved.
//


import XCTest

extension Tests {
    func testChanUnbuffered() {
        let count = 100
        let total = IntA(0)
        let xtotal = makeTotal(count)
        let nums = Chan<Int>()
        dispatch {
            NSThread.sleepForTimeInterval(0.05)
            while let i = <-nums {
                total += i
            }
        }
        for i in 0 ..< count {
            nums <- i
        }
        XCTAssert(nums.count() == 0, "The channel count should equal Zero.")
        nums.close()
        XCTAssert(xtotal == total, "The expected total is incorrect. xtotal: \(xtotal), total: \(total)")
        
    }
    func testChanBuffered() {
        let count = 100
        let total = IntA(0)
        let xtotal = makeTotal(count)
        let nums = Chan<Int>(10)
        let done = Chan<Bool>()
        dispatch {
            NSThread.sleepForTimeInterval(0.05)
            while let i = <-nums {
                total += i
            }
            done <- true
        }
        for i in 0 ..< count {
            nums <- i
        }
        nums.close()
        <-done
        XCTAssert(xtotal == total, "The expected total is incorrect. xtotal: \(xtotal), total: \(total)")
        
    }

    func testChanSelect() {
        let count = 100
        let total = IntA(0)
        let xtotal = makeTotal(count)
        let nums = Chan<Int>(10)
        let done = Chan<Bool>()
        dispatch {
            NSThread.sleepForTimeInterval(0.05)
            var chanOpened = true
            while chanOpened {
                _select {
                    _case(nums) { i in
                        if let i = i {
                            total += i
                        } else {
                            chanOpened = false
                        }
                    }
                }
            }
            done <- true
        }
        for i in 0 ..< count {
            nums <- i
        }
        nums.close()
        <-done
        XCTAssert(xtotal == total, "The expected total is incorrect. xtotal: \(xtotal), total: \(total)")
    }
    
    func testChanSelectMultiple() {
        let count = 100
        let total = IntA(0)
        let total2 = IntA(0)
        let xtotal = makeTotal(count)
        let nums = Chan<Int>(10)
        let nums2 = Chan<Int>()
        let done = Chan<Bool>()
        dispatch {
            NSThread.sleepForTimeInterval(0.05)
            var chanOpened = true
            var chanOpened2 = true
            while chanOpened || chanOpened2 {
                _select {
                    _case(nums) { i in
                        if let i = i {
                            total += i
                        } else {
                            chanOpened = false
                        }
                    }
                    _case(nums2) { i in
                        if let i = i {
                            total2 += i
                        } else {
                            chanOpened2 = false
                        }
                    }
                }
            }
            done <- true
        }
        for i in 0 ..< count {
            nums <- i
            nums2 <- i
        }
        nums.close()
        nums2.close()
        <-done
        XCTAssert(xtotal == total, "The expected total is incorrect. xtotal: \(xtotal), total: \(total)")
        XCTAssert(xtotal == total2, "The expected total is incorrect. xtotal: \(xtotal), total: \(total2)")
        
    }
    func testChanSelectDefault() {
        let count = 100
        let total = IntA(0)
        let total2 = IntA(0)
        let defaultUsed = BoolA(false)
        let xtotal = makeTotal(count)
        let nums = Chan<Int>(10)
        let nums2 = Chan<Int>()
        let done = Chan<Bool>()
        dispatch {
            NSThread.sleepForTimeInterval(0.05)
            var chanOpened = true
            var chanOpened2 = true
            while chanOpened || chanOpened2 {
                _select {
                    _case(nums) { i in
                        if let i = i {
                            total += i
                        } else {
                            chanOpened = false
                        }
                    }
                    _case(nums2) { i in
                        if let i = i {
                            total2 += i
                        } else {
                            chanOpened2 = false
                        }
                    }
                    _default {
                        NSThread.sleepForTimeInterval(0.05)
                        defaultUsed.store(true)
                    }
                }
            }
            done <- true
        }
        for i in 0 ..< count {
            nums <- i
            nums2 <- i
        }
        NSThread.sleepForTimeInterval(0.05)
        nums.close()
        nums2.close()
        <-done
        XCTAssert(xtotal == total, "The expected total is incorrect. xtotal: \(xtotal), total: \(total)")
        XCTAssert(xtotal == total2, "The expected total is incorrect. xtotal: \(xtotal), total: \(total2)")
        XCTAssert(defaultUsed == true, "Expecting default statment to be used.")
    }
}

