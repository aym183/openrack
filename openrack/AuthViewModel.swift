//
//  AuthViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 28/03/2023.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift


class AuthViewModel {
    
    func signInWithGoogle() {
//        var view : Application
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config
                
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                    
            if let error = error {
               return
            }
                    
             guard let user = result?.user,
                   let idToken = user.idToken else { return }
             
             let accessToken = user.accessToken
                    
             let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)

            // Use the credential to authenticate with Firebase

        }

    }
}
