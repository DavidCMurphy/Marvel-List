//
//  Models.swift
//  MarvelList
//
//  Created by David Murphy on 08/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import Foundation

enum URLType: String {
    case detail
    case wiki
    case comiclink
}

struct MResponse<T: Decodable>: Decodable {
    let data: MResult<T>
}

struct MResult<T: Decodable>: Decodable {
    let results: [T]
}

struct MCharacter: Decodable {
    let name: String
    let description: String?
    let thumbnail: MThumbnail
    let urls: [CharacterURL]
}

struct CharacterURL: Decodable {
    let type: String
    let url: String
}

struct MThumbnail: Decodable {
    let path: String
    let image_extension: String
    
    enum CodingKeys: String, CodingKey {
        case image_extension = "extension"
        case path
    }
}

extension MThumbnail {
    
    var image_url: String {
        return "\(path).\(image_extension)"
    }
}
