//
//  DetailViewModel.swift
//  MarvelList
//
//  Created by David Murphy on 08/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import Foundation

public let empty_description_messsage = "There is no description for this character"

struct DetailViewModel: DetailModelProtocol {
    
    typealias T = MCharacter
    
    var name: String
    var image_url: String
    var description: String
    var url: URL?
    
    init(_ model: T) {
        name = model.name
        image_url = model.thumbnail.image_url
        
        // assign the description if it exists
        if let desc = model.description, desc.count > 0 {
            description = desc
        } else {
            description = empty_description_messsage
        }
        
        // assign the URL if it exists and is valid
        if let charURL = model.urls.first(where: { $0.type == URLType.detail.rawValue }) {
            url = URL( string: charURL.url )
        } else {
            url = nil
        }
    }
}
