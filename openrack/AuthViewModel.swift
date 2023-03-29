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


class AuthViewModel : ObservableObject {
    
    let auth = Auth.auth()
    @Published var signedIn = false
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signUpWithEmail(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUpWithGoogle() {

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                    
            if let error = error { return }
             guard let user = result?.user,
                   let idToken = user.idToken else { return }
             
             let accessToken = user.accessToken
             let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        }
    }
}
