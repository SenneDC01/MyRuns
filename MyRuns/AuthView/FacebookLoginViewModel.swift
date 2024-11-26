//
//  FacebookLoginViewModel.swift
//  MyRuns
//
//  Created by Senne De Cock on 17/10/2024.
//

import Foundation
import FacebookLogin
import FirebaseAuth
import FacebookCore

class FacebookLoginViewModel: ObservableObject {

    let facebookLoginManager = LoginManager()
    
    @Published var facebookLoginModel = FacebookLoginModel()
    @Published var isAuthenticating = false
    @Published var isAuth = false
    @Published var error = ""
    @Published var showAlert = false
    
    init() {
        // Set up an auth state listener
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in, update the state accordingly
                self.isAuth = true
                self.facebookLoginModel.email = user.email
                self.facebookLoginModel.name = user.displayName
                
                // Fetch profile picture after login
                self.fetchFacebookProfileDetails()
            } else {
                // No user is signed in
                self.isAuth = false
                self.facebookLoginModel.email = nil
                self.facebookLoginModel.name = nil
                self.facebookLoginModel.profilePictureURL = nil // Clear the picture URL
            }
        }
    }

    func logIn() {
        self.isAuth = false
        self.showAlert = false
        self.isAuthenticating = true
        
        facebookLoginManager.logIn(permissions: ["public_profile", "email"], from: nil) { (result, error) in
            if let error = error {
                self.isAuthenticating = false
                self.error = error.localizedDescription
                self.showAlert = true
                return
            }

            guard let result = result else {
                self.isAuthenticating = false
                self.error = "Unknown error"
                self.showAlert = true
                return
            }
            
            if result.isCancelled {
                self.isAuthenticating = false
                print("User cancelled login.")
                return
            }
            
            // Successfully logged in
            print("DEBUG: Logged in! \(result.grantedPermissions) \(result.declinedPermissions) \(String(describing: result.token))")
            
            // Authenticate with Firebase using Facebook's access token
            if let accessToken = AccessToken.current?.tokenString {
                self.firebaseAuth(tokenString: accessToken, facebookName: result.token?.userID ?? "")
            }
        }
    }

    func fetchFacebookProfileDetails() {
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, email, picture.type(large)"]).start { connection, result, error in
            if let error = error {
                print("Error fetching user details: \(error.localizedDescription)")
                return
            }

            guard let fbProfileDetails = result as? NSDictionary else {
                print("Error: Unable to fetch profile details")
                return
            }

            // Access the profile details, including the picture URL
            print("DEBUG: FB details \(fbProfileDetails)")
            
            self.facebookLoginModel.name = fbProfileDetails.value(forKey: "name") as? String
            self.facebookLoginModel.email = fbProfileDetails.value(forKey: "email") as? String
            self.facebookLoginModel.profilePictureURL = fbProfileDetails.value(forKeyPath: "picture.data.url") as? String

            print("DEBUG: Profile Picture URL \(String(describing: self.facebookLoginModel.profilePictureURL))")
        }
    }

    func firebaseAuth(tokenString: String, facebookName: String){
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                self.error = error.localizedDescription
                self.showAlert = true
                self.isAuthenticating = false
                self.isAuth = false
                return
            }
            if result != nil {
                self.facebookLoginModel.email = result?.user.email
                self.facebookLoginModel.name = facebookName
                self.isAuthenticating = false
                self.isAuth = true
                print("DEBUG: Auth with Firebase success")
            }
        }
    }

    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        self.facebookLoginModel.email = ""
        self.facebookLoginModel.id = ""
        self.facebookLoginModel.name = ""
        self.facebookLoginModel.profilePictureURL = nil // Clear the profile picture URL
        self.isAuth = false
    }
}
