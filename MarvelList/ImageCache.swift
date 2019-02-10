//
//  ImageCache.swift
//  MarvelList
//
//  Created by David Murphy on 07/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit

public class ImageCache: NSCache<NSString, UIImage> {
    static let shared = ImageCache()
}

extension UIImageView {
    
    // loads a remote image with an animation if it hasnt come from the cache
    public func setRemoteImageWithAnimation( url: String ) {
        image = nil
        if let cached_image = ImageCache.shared.object(forKey: url as NSString ) {
            image = cached_image
            return
        }
        alpha = 0
        loadImageWithUrl(url: url) { [weak self] result in
            switch (result) {
            case .success( let image ):
                self?.image = image
                ImageCache.shared.setObject(image, forKey: url as NSString)
                UIView.animate(withDuration: 0.3) {
                    self?.alpha = 1
                }
            case .failure(_):
                self?.alpha = 1
            }
        }
    }
    
    // loads a remote image with a URL
    private func loadImageWithUrl( url: String, completion: @escaping (Result<UIImage>) -> Void ) {
        dataTask(url: url) { (result) in
            switch result {
            case .success(let data):
                if let result = UIImage(data: data) {
                    DispatchQueue.main.async { completion( Result.success( result ) ) }
                }
                return
            case .failure(_):
                DispatchQueue.main.async { completion( Result.failure(MarvelError.InvalidURL) ) }
                return
            }
        }
    }
}
