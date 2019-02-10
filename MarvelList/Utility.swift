//
//  Utility.swift
//  MarvelList
//
//  Created by David Murphy on 08/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit
import SafariServices

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIColor {

    struct FlatColor {
        struct Blue {
            static let Mariner = UIColor(netHex: 0x3585C5)
        }
        struct Gray {
            static let WhiteSmoke = UIColor(netHex: 0xEFEFEF)
        }
    }
}

extension UIView {
    
    func attachToSuper() {
        if let parent = superview {
            translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
            leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
        }
    }
}

extension UIViewController {
    
    func openSafari( _ url: URL? ) {
        if let safariURL = url {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: safariURL, configuration: config)
            present(vc, animated: true)
        }
    }
}
