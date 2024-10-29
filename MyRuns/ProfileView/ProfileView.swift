//
//  ProfileView.swift
//  MyRuns
//
//  Created by Guy De Cock on 16/10/2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var facebookLoginVM: FacebookLoginViewModel

    var body: some View {
        if facebookLoginVM.isAuth {
            VStack {
                if let profilePictureURL = facebookLoginVM.facebookLoginModel.profilePictureURL,
                   let url = URL(string: profilePictureURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                } else {
                    Text("No Profile Picture")
                }
                
                Text(facebookLoginVM.facebookLoginModel.name ?? "")
                
                if let email = facebookLoginVM.facebookLoginModel.email {
                    Text(email)
                }

                Button(action: {
                    facebookLoginVM.logOut()
                }) {
                    Text("Logout")
                }
            }
        } else {
            NavigationLink(destination: LoginView()) {
                Text("Login")
            }
        }
    }
}

#Preview {
    ProfileView(facebookLoginVM: FacebookLoginViewModel())
}
