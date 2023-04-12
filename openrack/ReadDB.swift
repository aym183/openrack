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
    
    func getCreatorShows() {
        @AppStorage("username") var userName: String = ""
        var userShows = UserDefaults.standard.array(forKey: "myKey") as? [[String:Any]] ?? []

        
        let db = Firestore.firestore()
        let ref = db.collection("shows")
        ref.whereField("created_by", isEqualTo: userName)
            .whereField("has_conducted", isEqualTo: false)
        
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getCreatorShows: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        userShows.append(document.data())
                    }
                }
                UserDefaults.standard.set(userShows, forKey: "shows")
            }

    }
    
    func getViewerShows() {
        @AppStorage("username") var userName: String = ""
        var viewerShows = UserDefaults.standard.array(forKey: "myViewerKey") as? [[String:Any]] ?? []

        let db = Firestore.firestore()
        let ref = db.collection("shows")
        ref.whereField("created_by", isNotEqualTo: userName)
            .whereField("has_conducted", isEqualTo: false)

            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getViewerShows: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        viewerShows.append(document.data())
                    }
                }
                UserDefaults.standard.set(viewerShows, forKey: "viewer_shows")
            }
    }
    
    func getStreamKey(liveStreamID: String) {
        @AppStorage("stream_key") var streamKey: String = ""

        let db = Firestore.firestore()
        let ref = db.collection("shows")
        ref.whereField("livestream_id", isEqualTo: liveStreamID)

            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getStreamKey: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        print("THE STREAM KEY IS \(String(describing:document.data()["stream_key"]!))")
                        UserDefaults.standard.set(String(describing:document.data()["stream_key"]!), forKey: "stream_key")
                    }
                }
            }
    }
}
