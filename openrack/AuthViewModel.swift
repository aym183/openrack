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
    let group = DispatchGroup()
    @Published var signedIn = false
    @AppStorage("email") var userEmail: String = ""
    @AppStorage("username") var userName: String = ""
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signUpWithEmail(email: String, password: String, username: String, fullName: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Successful auth")
                self.signedIn.toggle()
                CreateDB().addUser(email: email, username: username, fullName: fullName)
//                CreateDB().createStripeCustomer(name: fullName, email: email)
                UserDefaults.standard.set(email, forKey: "email")
                ReadDB().getUserDefaults()
                ReadDB().getViewerShows()
            }
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                    UserDefaults.standard.set(email, forKey: "email")
                    print(email)
                    ReadDB().getUserDefaults()
                    print("Successful auth")
                    self.signedIn.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        print("I'm here \(self.userName)")
                        ReadDB().getCreatorShows()
                        ReadDB().getViewerShows()
                    }
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
