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
    var getUsername = ReadDB()
    
    func addUser(email: String, username: String) {
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
                print("User added")
            }
            
        }
    }
    
    func addShow(name: String, description: String, date: String) {
        let db = Firestore.firestore()
        let ref = db.collection("shows")
        let group = DispatchGroup()
        @AppStorage("username") var userName: String = ""
        
        let data: [String: Any] = [
            "date_created": miscData.getPresentDateTime(),
            "date_scheduled": date,
            "created_by": userName,
            "name": name,
            "description": description,
            "has_conducted": false
        ]
        
        group.enter()
        DispatchQueue.global(qos: .background).async {
            ref.addDocument(data: data) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    print("Show added")
                }
            }
            
            group.leave()
        }
        group.wait() 
        
        ReadDB().getCreatorShows()
        ReadDB().getViewerShows()
    }
}
