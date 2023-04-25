//
//  AuthUIViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 29/03/2023.
//

import Foundation

class AuthUIViewModel: ObservableObject {
    
    func UIDetails(purpose: String) -> Array<Any> {
        
        var response: Array<Any>
        if purpose == "Email" {
            response = ["Sign Up", "Sign up for email to access sales, exclusive drops & more from Openrack", "Submit", "Yes"]
        } else if purpose == "Phone Sign In"  {
            response = ["Enter Phone Number", "Verification", "Verify", "Phone"]
        } else {
            response = ["Login", "Remember Me", "Submit", "No"]
        }
        return response
    }
}
