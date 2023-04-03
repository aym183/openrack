//
//  AuthUIViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 29/03/2023.
//

import Foundation

class AuthUIViewModel {
    
    func UIDetails(purpose: String) -> Array<Any> {
        
        var response: Array<Any>
        if purpose == "Sign In" {
            response = ["Sign Up", "Sign up for email to access sales, exclusive drops & more from Openrack", "Next", "Yes", UserUsername()]
        } else {
            // Rename LandingPage to home page
            response = ["Login", "Remember Me", "Submit", "No", FeedPage()]
        }
        return response
    }
}
