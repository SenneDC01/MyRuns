//
//  FirebaseAuthManager.swift
//  MyRuns
//
//  Created by Guy De Cock on 17/10/2024.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager: ObservableObject {
    
    func login(credential: AuthCredential, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(with: credential, completion: { (firebaseUser, error) in
            print(firebaseUser ?? "default user")
            completionBlock(error == nil)
        })
    }
}
