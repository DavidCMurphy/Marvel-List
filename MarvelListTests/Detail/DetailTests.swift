//
//  DetailTests.swift
//  MarvelListTests
//
//  Created by David Murphy on 10/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit
import XCTest
@testable import MarvelList

class DetailTests: XCTestCase {
    
    // test if we display the correct empty message for the description
    func testListViewModel() {
        let thumbnail = MThumbnail(path: "", image_extension: "")
        let character = MCharacter(name: "David", description: "", thumbnail: thumbnail, urls: [])
        let viewModel = DetailViewModel( character )
        XCTAssertEqual(viewModel.description, empty_description_messsage)
    }
    
    // test correct data for details, with a shown url button and correct title
    func testDetailsModel() {
        let viewModel = AnyListModel( "TestResponse", ListViewModel(), MockFetchResponse() )
        viewModel.reload()
        if let detail = viewModel.results()?[0] {
            let detailModel = DetailViewModel( detail )
            XCTAssertEqual(detailModel.name, detail.name)
            XCTAssertEqual(detailModel.image_url, detail.thumbnail.image_url)
            XCTAssertEqual(detailModel.description, detail.description)
            XCTAssertNotNil(detailModel.url)
            
            let controller = CharacterDetailController( detailModel )
            controller.viewDidLoad()
            XCTAssertEqual( controller.title, detailModel.name)
            XCTAssertFalse( controller.urlButton.isHidden )
        } else {
            XCTAssertTrue(false)
        }
    }
    
    // test we correctly hide the details bitton when there is no url
    func testHiddenUrlButton() {
        let thumbnail = MThumbnail(path: "", image_extension: "")
        let character = MCharacter(name: "David", description: "", thumbnail: thumbnail, urls: [])
        let viewModel = DetailViewModel( character )
        let controller = CharacterDetailController( viewModel )
        controller.viewDidLoad()
        XCTAssertTrue( controller.urlButton.isHidden )
    }
    
}
