//
//  LoginView.swift
//  MyRuns
//
//  Created by Guy De Cock on 17/10/2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var facebookLoginVM = FacebookLoginViewModel()
    @Environment(\.dismiss) var dismiss  // To dismiss the login screen
    
    var body: some View {
        VStack(spacing:50){
            Spacer()
            
            // other logins
            Button(action: {
                if !facebookLoginVM.isAuth{
                    facebookLoginVM.logIn()
                }else{
                    facebookLoginVM.logOut()
                }
            }, label: {
                if !facebookLoginVM.isAuthenticating{
                    Text(facebookLoginVM.isAuth ? "Log Out" : "Continue via Facebook")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }else{
                    ProgressView()
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            })
            Spacer()
        }
        .padding(.horizontal)
        .alert(facebookLoginVM.error, isPresented: $facebookLoginVM.showAlert) {
            Button("OK", role: .cancel) { }
        }
        .onChange(of: facebookLoginVM.isAuth) { oldVal, isAuthenticated in
            if isAuthenticated {
                dismiss()  // Dismiss the login view and return to the previous view
            }
        }
    }
}

#Preview {
    LoginView()
}
