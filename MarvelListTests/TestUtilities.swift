//
//  TestUtilities.swift
//  MarvelListTests
//
//  Created by David Murphy on 10/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import Foundation
@testable import MarvelList

func decodeFile<T: Decodable>(_ file: String, _ type: T.Type, _ completion: @escaping (Result<T>) -> Void) -> Void {
    if let url = Bundle.main.url(forResource: file, withExtension: "json"), let data = try? Data(contentsOf: url) {
        let result: Result<T> = decodeResult( Result.success(data) )
        completion( result )
        return
    }
    completion( Result.failure(MarvelError.InvalidURL) )
}

struct Dog: Decodable {
    let name: String
}

struct MockFetchResponse: FetchProtocol {
    
    typealias T = Response
    
    func fetch(_ url: String , _ type: T.Type, _ completion: @escaping (Result<T>) -> Void) {
        decodeFile( url, type, completion )
    }
}

struct MockFetchNothing: FetchProtocol {
    
    typealias T = Response
    
    func fetch(_ url: String , _ type: T.Type, _ completion: @escaping (Result<T>) -> Void) {
    }
}

struct MockFetchDog: FetchProtocol {
    
    typealias T = Dog
    
    func fetch(_ url: String , _ type: T.Type, _ completion: @escaping (Result<T>) -> Void) {
        decodeFile( url, type, completion )
    }
}
