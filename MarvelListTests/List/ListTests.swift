//
//  ListTests.swift
//  MarvelListTests
//
//  Created by David Murphy on 10/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit

import XCTest
@testable import MarvelList

class ListTests: XCTestCase {
    
    // test if we enter the correct loading state
    func testListViewModel() {
        let viewModel = AnyListModel( "TestResponse", ListViewModel(), MockFetchNothing() )
        viewModel.reload()
        XCTAssertTrue(viewModel.loading.value == true)
    }
    
    // tests whether a controller renders the correct information when injected with data
    func testSuccessfulDetailController() {
        let viewModel = ListViewModel()
        let controller = CharacterListController( "TestResponse", viewModel, MockFetchResponse() )
        controller.viewDidLoad()
        XCTAssertEqual( controller.title, viewModel.title )
        XCTAssertFalse( controller.activity.isAnimating )
        XCTAssertTrue( controller.table.numberOfRows(inSection: 0) == 25 )
    }
    
}
