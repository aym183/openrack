//
//  AuthViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 28/03/2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift


class AuthViewModel : ObservableObject {
    
    let auth = Auth.auth()
    @Published var signedIn = false
    @AppStorage("email") var userEmail: String = ""
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signUpWithEmail(email: String, password: String, username: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Successful auth")
                self.signedIn.toggle()
                CreateDB().addUser(email: email, username: username)
                ReadDB().getUsername()
                UserDefaults.standard.set(email, forKey: "email")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                    print("Successful auth")
                    self.signedIn.toggle()
                    ReadDB().getUsername()
                    UserDefaults.standard.set(email, forKey: "email")
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
