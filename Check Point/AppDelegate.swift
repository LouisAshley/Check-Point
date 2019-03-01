//
//  AppDelegate.swift
//  Check Point
//
//  Created by Lewis on 27/02/2019.
//  Copyright © 2019 Lewis Crennell. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // how to find the realm file to view the database
//         print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print("Ream had an error initialising \(error)")
        }
        
        return true
    }
    
    
}


