//
//  AppDelegate.swift
//  MyRuns
//
//  Created by Guy De Cock on 17/10/2024.
//

import SwiftUI
import FirebaseCore
import FacebookLogin

class AppDelegate: NSObject, UIApplicationDelegate {    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
   
        return ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
}
