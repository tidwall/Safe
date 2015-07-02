//
//  atomic-test.swift
//  Safe
//
//  Created by Josh Baker on 7/1/15.
//  Copyright © 2015 ONcast. All rights reserved.
//

import XCTest

// TEMPLATE: Test
extension Tests {
    func testAtomic{{.Type}}() {
{{.Content}}
    }
}
// TEMPLATE: Operator['join']
        do {
            {{.InitVars}}
            n = n {{.Op}} {{.Del}}2{{.Del}}
            a = a {{.Op}} {{.Del}}2{{.Del}}
            {{.Assert}}
        }
// TEMPLATE: Operator['combine']
        do {
            {{.InitVars}}
            n {{.Op}} {{.Del}}2{{.Del}}
            a {{.Op}} {{.Del}}2{{.Del}}
            {{.Assert}}
        }
// TEMPLATE: Operator['prefix']
        do {
            {{.InitVars}}
            {{.Op}}n
            {{.Op}}a
            {{.Assert}}
        }
// TEMPLATE: Operator['prefix-assign']
        do {
            {{.InitVars}}
            n = {{.Op}}n
            a = {{.Op}}a
            {{.Assert}}
        }
// TEMPLATE: Operator['postfix']
        do {
            {{.InitVars}}
            n{{.Op}}
            a{{.Op}}
            {{.Assert}}
        }
// TEMPLATE: Operator['modify']
        do {
            {{.InitVars}}
            n {{.Op}} {{.Del}}2{{.Del}}
            a {{.Op}} {{.Del}}2{{.Del}}
            {{.Assert}}
        }
// TEMPLATE: InitVars
var (n, a) = ({{.Type}}({{.Del}}47{{.Del}}), {{.Type}}A({{.Del}}47{{.Del}}))
// TEMPLATE: Assert
XCTAssert(n == a, "Mismatch")














