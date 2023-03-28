//
//  Login_ViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 28/03/2023.
//

import SwiftUI
import Firebase
import GoogleSignIn

class SignUpViewModel: ObservableObject {
    @Published var isLogin: Bool = false

    func signUpWithGoogl() {
        let clientId = Firebase.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientId)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: <#T##UIViewController#>)
    }
}
