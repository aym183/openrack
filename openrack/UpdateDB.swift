//
//  UpdateDB.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//

import Foundation
import FirebaseFirestore
import Firebase
import SwiftUI

class UpdateDB : ObservableObject {
    var miscData = MiscData()
    
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
    
    func updateStripeCustomerID(customerID: String) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        @AppStorage("username") var userName: String = ""
        
        // Query for documents where "name" equals "X"
        collectionRef.whereField("username", isEqualTo: userName).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents on updateStripeCustomerID: \(error)")
            } else {
                guard let document = querySnapshot?.documents.first else {
                    print("No documents found")
                    return
                }
                
                // Update "Y" field to "Text" for each document where "name" equals "X"
                let docRef = collectionRef.document(document.documentID)
                docRef.updateData(["stripe_customer_id": customerID])
                UserDefaults.standard.set(String(describing: customerID), forKey: "stripe_customer_id")
            }
        }
    }
    
    func updateStripePaymentMethodID(paymentMethodID: String) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        @AppStorage("username") var userName: String = ""
        
        // Query for documents where "name" equals "X"
        collectionRef.whereField("username", isEqualTo: userName).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents on updateStripeCustomerID: \(error)")
            } else {
                guard let document = querySnapshot?.documents.first else {
                    print("No documents found")
                    return
                }
                
                // Update "Y" field to "Text" for each document where "name" equals "X"
                let docRef = collectionRef.document(document.documentID)
                docRef.updateData(["stripe_payment_method": paymentMethodID])
                UserDefaults.standard.set(String(describing: paymentMethodID), forKey: "stripe_payment_method")
            }
        }
    }
    
    func updateStripePaymentDetails(paymentDetails: [String]) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        @AppStorage("username") var userName: String = ""
        
        // Query for documents where "name" equals "X"
        collectionRef.whereField("username", isEqualTo: userName).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents on updateStripeCustomerID: \(error)")
            } else {
                guard let document = querySnapshot?.documents.first else {
                    print("No documents found")
                    return
                }
                
                // Update "Y" field to "Text" for each document where "name" equals "X"
                let docRef = collectionRef.document(document.documentID)
                docRef.updateData(["card_brand": paymentDetails[0]])
                docRef.updateData(["last_four": paymentDetails[1]])
            }
        }
    }
    
    func updateListings(listing: [String: String], docRef: String) {
        let db = Firestore.firestore()
        let ref = db.collection("listings")
        var docID = ref.document(docRef)
        var presentDateTime = miscData.getPresentDateTime()
        
        var documentData = [String: Any]()
//        for _ in 0..<count! {
        var fieldID = ref.document()
        documentData[fieldID.documentID] = ["name": listing["name"], "description": listing["description"], "quantity": listing["quantity"], "category": listing["category"], "subcategory": listing["subcategory"], "price": listing["price"], "type": listing["type"], "date_created": presentDateTime]
//        }
        docID.updateData(documentData) { error in
        if let error = error {
            print("Error adding listing: \(error.localizedDescription)")
        } else {
            print("Document added successfully!")
            ReadDB().getListings()
        }
        }
    }
    
    func updateUserAddress(address: [String: Any]) {
        @AppStorage("username") var userName: String = ""
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        
        collectionRef.whereField("username", isEqualTo: userName).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents on updateStatus: \(error)")
            } else {
                guard let document = querySnapshot?.documents.first else {
                    print("No documents found")
                    return
                }
                
                // Update "Y" field to "Text" for each document where "name" equals "X"
                let docRef = collectionRef.document(document.documentID)
                docRef.updateData(address)
            }
        }
        
    }
    
    // ------------------------- Realtime Database ---------------------------------
    
    func updateListingSelected(listingID: String, listing: Listing) {
        
        let dbRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
        
        dbRef.updateChildValues(["title": listing.title, "price": listing.price == "0" ? listing.type : listing.price ]) { error, ref in
            if let error = error {
                print("Error updating name: \(error.localizedDescription)")
            } else {
                print("Realtime Listing Selected Updated")
            }
        }

    }
    
    
    // ------------------------- Realtime Database ---------------------------------
    
    func updateListingSold(listingID: String) {
        let showsRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
        showsRef.child("is_sold").setValue(true)
    }
    
}
