//
//  Dynamic.swift
//  MarvelList
//
//  Created by David Murphy on 07/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T?) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T?) {
        value = v
    }
}
