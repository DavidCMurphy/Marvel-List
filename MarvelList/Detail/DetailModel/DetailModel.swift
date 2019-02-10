//
//  DetailModel.swift
//  MarvelList
//
//  Created by David Murphy on 09/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import Foundation

protocol DetailModelProtocol {
    
    associatedtype T
    
    var name: String { get }
    var image_url: String { get }
    var description: String { get }
    var url: URL? { get }
    
    init( _ model: T )
}
