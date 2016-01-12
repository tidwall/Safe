//
//  atomic-test.swift
//  Safe
//
//  Created by Josh Baker on 7/1/15.
//  Copyright © 2015 ONcast. All rights reserved.
//

import XCTest


																																																																																																																																																		
extension Tests {
    func testAtomicInt() {
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int(47), IntA(47))
            n = +n
            a = +a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = -n
            a = -a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n = ~n
            a = ~a
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int(47), IntA(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int(47), IntA(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicInt64() {
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = +n
            a = +a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = -n
            a = -a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n = ~n
            a = ~a
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int64(47), Int64A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicInt32() {
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = +n
            a = +a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = -n
            a = -a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n = ~n
            a = ~a
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int32(47), Int32A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicInt16() {
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = +n
            a = +a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = -n
            a = -a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n = ~n
            a = ~a
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int16(47), Int16A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicInt8() {
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = +n
            a = +a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = -n
            a = -a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n = ~n
            a = ~a
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Int8(47), Int8A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicUInt() {
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        
        
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt(47), UIntA(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicUInt64() {
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        
        
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt64(47), UInt64A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicUInt32() {
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        
        
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt32(47), UInt32A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicUInt16() {
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        
        
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt16(47), UInt16A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicUInt8() {
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n << 2
            a = a << 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n >> 2
            a = a >> 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n ^ 2
            a = a ^ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n & 2
            a = a & 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n &+ 2
            a = a &+ 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n &- 2
            a = a &- 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n = n &* 2
            a = a &* 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        
        
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n <<= 2
            a <<= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n >>= 2
            a >>= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n ^= 2
            a ^= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (UInt8(47), UInt8A(47))
            n &= 2
            a &= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicDouble() {
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n = +n
            a = +a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n = -n
            a = -a
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Double(47), DoubleA(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicFloat() {
        do {
            var (n, a) = (Float(47), FloatA(47))
            n = n + 2
            a = a + 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n = n - 2
            a = a - 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n = n * 2
            a = a * 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n = n / 2
            a = a / 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n = n % 2
            a = a % 2
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Float(47), FloatA(47))
            n = +n
            a = +a
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n = -n
            a = -a
            XCTAssert(n == a, "Mismatch")
        }
        
        
        do {
            var (n, a) = (Float(47), FloatA(47))
            n += 2
            a += 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n -= 2
            a -= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n *= 2
            a *= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n /= 2
            a /= 2
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (Float(47), FloatA(47))
            n %= 2
            a %= 2
            XCTAssert(n == a, "Mismatch")
        }

    }
}
extension Tests {
    func testAtomicBool() {

    }
}
extension Tests {
    func testAtomicString() {
        do {
            var (n, a) = (String("47"), StringA("47"))
            n = n + "2"
            a = a + "2"
            XCTAssert(n == a, "Mismatch")
        }
        do {
            var (n, a) = (String("47"), StringA("47"))
            n += "2"
            a += "2"
            XCTAssert(n == a, "Mismatch")
        }

    }
}
