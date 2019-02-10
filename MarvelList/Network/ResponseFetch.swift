//
//  ResponseFetch.swift
//  MarvelList
//
//  Created by David Murphy on 09/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import Foundation

typealias Response = MResponse<MCharacter>

struct ResponseFetch: FetchProtocol {
    
    typealias T = Response
    
    func fetch(_ url: String, _ type: Response.Type, _ completion: @escaping (Result<Response>) -> Void) {
        fetchDecodeResult( url, type, completion )
    }
}
