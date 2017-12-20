//
//  APIKitTests.swift
//  APIKitTests
//
//  Created by Yoshiki Miyazawa on 2017/12/20.
//  Copyright © 2017年 yochio. All rights reserved.
//

import XCTest
@testable import APIKit

class APIKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJapaneseQueryParameters() {
        let request = TestRequest(parameters: ["q": "こんにちは"] )
        let urlRequest = try? request.buildURLRequest()
        
        print(urlRequest)
        XCTAssert(true)
    }
    
    func testBuildURL() {
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com", path: "").absoluteURL,
            URL(string: "https://example.com")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "foo").absoluteURL,
        URL(string: "https://example.com/foo")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/foo?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo/").absoluteURL,
        URL(string: "https://example.com/foo/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/foo/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "foo/bar").absoluteURL,
        URL(string: "https://example.com/foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo/bar").absoluteURL,
        URL(string: "https://example.com/foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo/bar", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/foo/bar?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo/bar/").absoluteURL,
        URL(string: "https://example.com/foo/bar/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo/bar/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/foo/bar/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com", path: "/foo/bar//").absoluteURL,
        URL(string: "https://example.com/foo/bar//")
        )
        
        // MARK: - baseURL = https://example.com/
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "").absoluteURL,
        URL(string: "https://example.com/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/").absoluteURL,
        URL(string: "https://example.com//")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com//?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "foo").absoluteURL,
        URL(string: "https://example.com/foo")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo").absoluteURL,
        URL(string: "https://example.com//foo")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com//foo?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo/").absoluteURL,
        URL(string: "https://example.com//foo/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com//foo/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "foo/bar").absoluteURL,
        URL(string: "https://example.com/foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo/bar").absoluteURL,
        URL(string: "https://example.com//foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo/bar", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com//foo/bar?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo/bar/").absoluteURL,
        URL(string: "https://example.com//foo/bar/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "/foo/bar/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com//foo/bar/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/", path: "foo//bar//").absoluteURL,
        URL(string: "https://example.com/foo//bar//")
        )
        
        // MARK: - baseURL = https://example.com/api
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "").absoluteURL,
        URL(string: "https://example.com/api")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/").absoluteURL,
        URL(string: "https://example.com/api/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "foo").absoluteURL,
        URL(string: "https://example.com/api/foo")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo").absoluteURL,
        URL(string: "https://example.com/api/foo")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api/foo?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo/").absoluteURL,
        URL(string: "https://example.com/api/foo/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api/foo/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "foo/bar").absoluteURL,
        URL(string: "https://example.com/api/foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo/bar").absoluteURL,
        URL(string: "https://example.com/api/foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo/bar", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api/foo/bar?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo/bar/").absoluteURL,
        URL(string: "https://example.com/api/foo/bar/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "/foo/bar/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api/foo/bar/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api", path: "foo//bar//").absoluteURL,
        URL(string: "https://example.com/api/foo//bar//")
        )
        
        // MARK: - baseURL = https://example.com/api/
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "").absoluteURL,
        URL(string: "https://example.com/api/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/").absoluteURL,
        URL(string: "https://example.com/api//")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api//?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "foo").absoluteURL,
        URL(string: "https://example.com/api/foo")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/foo").absoluteURL,
        URL(string: "https://example.com/api//foo")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/foo", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api//foo?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/foo/").absoluteURL,
        URL(string: "https://example.com/api//foo/")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/foo/", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api//foo/?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "foo/bar").absoluteURL,
        URL(string: "https://example.com/api/foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/foo/bar").absoluteURL,
        URL(string: "https://example.com/api//foo/bar")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/foo/bar", parameters: ["p": 1]).absoluteURL,
        URL(string: "https://example.com/api//foo/bar?p=1")
        )
        
        XCTAssertEqual(
        TestRequest(baseURL: "https://example.com/api/", path: "/foo/bar/").absoluteURL,
        URL(string: "https://example.com/api//foo/bar/")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com/api/", path: "/foo/bar/", parameters: ["p": 1]).absoluteURL,
            URL(string: "https://example.com/api//foo/bar/?p=1")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com/api/", path: "foo//bar//").absoluteURL,
            URL(string: "https://example.com/api/foo//bar//")
        )
        
        //　MARK: - baseURL = https://example.com///
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "").absoluteURL,
            URL(string: "https://example.com///")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/").absoluteURL,
            URL(string: "https://example.com////")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/", parameters: ["p": 1]).absoluteURL,
            URL(string: "https://example.com////?p=1")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "foo").absoluteURL,
            URL(string: "https://example.com///foo")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo").absoluteURL,
            URL(string: "https://example.com////foo")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo", parameters: ["p": 1]).absoluteURL,
            URL(string: "https://example.com////foo?p=1")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo/").absoluteURL,
            URL(string: "https://example.com////foo/")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo/", parameters: ["p": 1]).absoluteURL,
            URL(string: "https://example.com////foo/?p=1")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "foo/bar").absoluteURL,
            URL(string: "https://example.com///foo/bar")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo/bar").absoluteURL,
            URL(string: "https://example.com////foo/bar")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo/bar", parameters: ["p": 1]).absoluteURL,
            URL(string: "https://example.com////foo/bar?p=1")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo/bar/").absoluteURL,
            URL(string: "https://example.com////foo/bar/")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "/foo/bar/", parameters: ["p": 1]).absoluteURL,
            URL(string: "https://example.com////foo/bar/?p=1")
        )
        
        XCTAssertEqual(
            TestRequest(baseURL: "https://example.com///", path: "foo//bar//").absoluteURL,
            URL(string: "https://example.com///foo//bar//")
        )
    }
    
}
