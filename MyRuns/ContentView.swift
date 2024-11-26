//
//  ContentView.swift
//  MyRuns
//
//  Created by Senne De Cock on 16/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Feed", systemImage: "house") {
                    FeedView()
                }
                .badge(2)
                Tab("Run", systemImage: "figure.run") {
                    RunView()
                }
                Tab("Profile", systemImage: "person.crop.circle") {
                    ProfileView(facebookLoginVM: FacebookLoginViewModel())
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
