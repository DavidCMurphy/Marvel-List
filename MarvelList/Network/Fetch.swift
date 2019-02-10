//
//  Fetch.swift
//  MarvelList
//
//  Created by David Murphy on 09/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit

typealias FetchCompletion<T> = ( ( Result<T> ) -> Void )

typealias FetchDecode<T> = ( _ url: String, _ type: T.Type, _ completion: @escaping FetchCompletion<T> ) -> Void

protocol FetchProtocol {
    
    associatedtype T
    
    func fetch( _ url: String, _ type: T.Type, _ completion: @escaping FetchCompletion<T> ) -> Void
}

class AnyFetch<T>: FetchProtocol {
    
    private let fetchClosure: FetchDecode<T>
    
    init<K: FetchProtocol>( _ fetcher: K) where K.T == T {
        fetchClosure = fetcher.fetch
    }
    
    func fetch( _ url: String, _ type: T.Type, _ completion: @escaping FetchCompletion<T> ) -> Void {
        return fetchClosure( url, type, completion )
    }
}
