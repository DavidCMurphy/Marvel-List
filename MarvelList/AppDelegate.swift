//
//  AppDelegate.swift
//  MarvelList
//
//  Created by David Murphy on 10/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit

public let marvel_url = "http://gateway.marvel.com/v1/public/characters?ts=1&apikey=ff3d4847092294acc724123682af904b&hash=412b0d63f1d175474216fadfcc4e4fed&limit=25&orderBy=-modified"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigation = UINavigationController(rootViewController: CharacterListController( marvel_url , ListViewModel(), ResponseFetch() ) )
        navigation.navigationBar.isTranslucent = false
        window?.rootViewController = navigation
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        return true
    }
}

