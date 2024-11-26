//
//  MyRunsApp.swift
//  MyRuns
//
//  Created by Senne De Cock on 16/10/2024.
//

import SwiftUI
import FacebookLogin

@main
struct MyRunsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    ApplicationDelegate.shared.application(UIApplication.shared,
                                                           open: url,sourceApplication: nil,
                                                           annotation: UIApplication.OpenURLOptionsKey.annotation)
                }
        }
    }
}
