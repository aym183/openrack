//
//  CreateDB.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//

import SwiftUI
import Firebase
import Foundation

class CreateDB : ObservableObject {
    var miscData = TimeData()
    
    func addUser(email: String, username: String) {
        let randomID = miscData.getRandomID()
        let db = Firestore.firestore()
        let ref = db.collection("users")
        let data: [String: Any] = [
            "date_created": miscData.getPresentDateTime(),
            "last_updated": miscData.getPresentDateTime(),
            "email": email,
            "username": username
        ]
        
        ref.addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added with ID")
            }
            
        }
    }
}
