//
//  ReadDB.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//

import Foundation
import Firebase
import SwiftUI

class ReadDB : ObservableObject {
    
    func getUsername() {
        @AppStorage("username") var userName: String = ""
        @AppStorage("email") var userEmail: String = ""
        let db = Firestore.firestore()
        let ref = db.collection("users")
        
        ref.whereField("email", isEqualTo: userEmail)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getUsername: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        UserDefaults.standard.set(String(describing:document.data()["username"]!), forKey: "username")
                    }
                }
            }
    }
}
