//
//  MarvelListTests.swift
//  MarvelListTests
//
//  Created by David Murphy on 06/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import XCTest
@testable import MarvelList

class FetchTests: XCTestCase {

    // test whether a sample file is decoded correctly
    func testSuccessDecode() {
        MockFetchResponse().fetch("TestResponse", Response.self) { result in
            switch ( result ) {
            case Result.success( let result ):
                XCTAssert( result.data.results.count == 25 )
                return
            case Result.failure( let error ):
                XCTAssertNil( error )
                return
            }
        }
    }
    
    // test whether an incorrect mapping fails as expected
    func testFailDecode() {
        MockFetchDog().fetch("TestResponse", Dog.self) { result in
            switch ( result ) {
            case Result.success( let result ):
                XCTAssertNil( result )
                return
            case Result.failure( let error ):
                XCTAssertEqual( error, MarvelError.InvalidMapping )
                return
            }
        }
    }
    
    // test whether a real request has correct URL validation
    func testInvalidURL() {
        ResponseFetch().fetch("", Response.self) { result in
            switch ( result ) {
            case Result.success( let result ):
                XCTAssertNil( result )
                return
            case Result.failure( let error ):
                XCTAssertEqual( error, MarvelError.InvalidURL )
                return
            }
        }
    }

}
