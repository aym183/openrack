//
//  UpdateDB.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//

import Foundation
import FirebaseFirestore

class UpdateDB : ObservableObject {
    var miscData = TimeData()
    
    func updateStatus(text: String, livestreamID: String) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("shows")
        
        // Query for documents where "name" equals "X"
        collectionRef.whereField("livestream_id", isEqualTo: livestreamID).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents on updateStatus: \(error)")
            } else {
                guard let document = querySnapshot?.documents.first else {
                    print("No documents found")
                    return
                }
                
                // Update "Y" field to "Text" for each document where "name" equals "X"
                let docRef = collectionRef.document(document.documentID)
                docRef.updateData(["status": text])
            }
        }
    }
    
    func updateListings(listing: [String], docRef: String) {
        let db = Firestore.firestore()
        let ref = db.collection("listings")
        var docID = ref.document(docRef)
        let count = Int(listing[2])
        var presentDateTime = miscData.getPresentDateTime()
        
        var documentData = [String: Any]()
        for _ in 0..<count! {
            var fieldID = ref.document()
            documentData[fieldID.documentID] = [listing[0], listing[1], listing[3], listing[4], presentDateTime]
        }
        docID.updateData(documentData) { error in
        if let error = error {
            print("Error adding listing: \(error.localizedDescription)")
        } else {
            print("Document added successfully!")
        }
        }
            }
}
