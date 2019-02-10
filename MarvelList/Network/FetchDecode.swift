//
//  FetchDecode.swift
//  MarvelList
//
//  Created by David Murphy on 09/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(MarvelError)
}

enum MarvelError: Error {
    case InvalidURL
    case InvalidMapping
    case NetworkError
}

func dataTask( url: String, completion: @escaping (Result<Data>) -> Void) {
    if let url = URL(string: url) {
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let d = data {
                completion( Result.success(d) )
            } else {
                completion( Result.failure(MarvelError.NetworkError) )
            }
            return
        }
        session.resume()
    } else {
        completion( Result.failure(MarvelError.InvalidURL) )
    }
}

func decodeResult<T: Decodable>( _ result: Result<Data> ) -> Result<T> {
    switch result {
    case .success(let data):
        if let result = try? JSONDecoder().decode( T.self, from: data) {
            return Result.success(result)
        }
        return Result.failure(MarvelError.InvalidMapping )
    case .failure(let error):
        return Result.failure( error )
    }
}

func fetchDecodeResult<T: Decodable>( _ url: String, _ type: T.Type, _ completion: @escaping (Result<T>) -> Void) {
    dataTask(url: url) { result in
        DispatchQueue.main.async { completion( decodeResult( result ) ) }
    }
}
