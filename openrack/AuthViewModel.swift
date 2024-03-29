//
//  AuthViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 28/03/2023.
//
import Foundation
import SwiftUI
import Firebase
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
                self.signedIn.toggle()
                CreateDB().addUser(email: email, username: username, fullName: fullName)
                UserDefaults.standard.set(username, forKey: "username")
                ReadDB().getUserDefaults()
                ReadDB().getViewerLiveShows()
            }
        }
    }

    func signIn(username: String, email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                    UserDefaults.standard.set(username, forKey: "username")
                    ReadDB().getUserDefaults()
                    self.signedIn.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        ReadDB().getCreatorShows()
                        ReadDB().getViewerLiveShows()
                    }
            }
        }
    }
    
    func phoneSignIn(phoneNumber: String, username: String, fullName: String, credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                    UserDefaults.standard.set(username, forKey: "username")
                    ReadDB().getUserDefaults()
                    CreateDB().addPhoneUser(phoneNumber: phoneNumber, username: username, fullName: fullName)
                    self.signedIn.toggle()
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
