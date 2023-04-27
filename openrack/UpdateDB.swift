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
    var previousWorkItem: DispatchWorkItem?
    
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
    
    func updateUserDetails(inputs: [String:String]) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        @AppStorage("username") var userName: String = ""
        
        // Query for documents where "name" equals "X"
        collectionRef.whereField("username", isEqualTo: userName).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents on updateUserDetails: \(error)")
            } else {
                guard let document = querySnapshot?.documents.first else {
                    print("No documents found")
                    return
                }
                
                // Update "Y" field to "Text" for each document where "name" equals "X"
                let docRef = collectionRef.document(document.documentID)
                // Add phone number
                docRef.updateData(["full_name": inputs["full_name"]])
                ReadDB().getUserDefaults()
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
                ReadDB().getCardDetails()
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
        documentData[fieldID.documentID] = ["name": listing["name"], "description": listing["description"], "quantity": listing["quantity"], "price": listing["price"], "type": listing["type"], "date_created": presentDateTime]
//        , "category": listing["category"], "subcategory": listing["subcategory"]
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
                ReadDB().getAddress()
            }
        }
        
    }
    
    // ------------------------- Realtime Database ---------------------------------
    
    func updateListingSelected(listingID: String, listing: Listing) {
        
        let dbRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
        
        dbRef.updateChildValues(["title": listing.title, "price": listing.price == "0" ? "10" : listing.price, "is_sold": false, "type": listing.type, "current_bidder": "", "highest_bid": "", "timer": ""]) { error, ref in
            if let error = error {
                print("Error updating name: \(error.localizedDescription)")
            } else {
                print("Realtime Listing Selected Updated")
            }
        }

    }
    
    func updateHighestBid(listingID: String, bid: String, bidder: String) {
        
        let dbRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
        
        dbRef.updateChildValues(["highest_bid": bid, "current_bidder": bidder]) { error, ref in
            if let error = error {
                print("Error updating bid: \(error.localizedDescription)")
            } else {
                print("Realtime Current Bid Updated")
            }
        }

    }
    
    func updateTimer(listingID: String, start_time: String, viewer_side: Bool) {

        print(previousWorkItem)
        
        if previousWorkItem != nil {
            previousWorkItem?.cancel()
            print(previousWorkItem)
            print("I cancelled")
        }
        
//        DispatchQueue.global(qos: .background).async {
        let workItem = DispatchWorkItem {
            let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            let dbRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
            var count = 0
            
            let components = start_time.components(separatedBy: ":")
            let minutes = Int(components[0]) ?? 0
            let seconds = Int(components[1]) ?? 0
            let totalSeconds = minutes * 60 + seconds
            let newMinutes = totalSeconds / 60
            var newSeconds = totalSeconds % 60
            
            if viewer_side {
                newSeconds += 5
            }
            
            print(newSeconds)
            while newSeconds >= 0 {
                sleep(1)
                if newSeconds < 10 {
                    dbRef.updateChildValues(["timer": "0\(newMinutes):0\(newSeconds)"]) { error, ref in
                        if let error = error {
                            print("Error updating timer: \(error.localizedDescription)")
                        }
                    }
                } else {
                    dbRef.updateChildValues(["timer": "0\(newMinutes):\(newSeconds)"]) { error, ref in
                        if let error = error {
                            print("Error updating timer: \(error.localizedDescription)")
                        }
                    }
                }
                
                newSeconds -= 1
            }
        }
//        }
        
        
        DispatchQueue.global(qos: .background).async(execute: workItem)
        
        previousWorkItem = workItem
        
        print(previousWorkItem)
    }

    
    func updateListingSold(listingID: String) {
        let showsRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
        showsRef.child("is_sold").setValue(true)
    }
    
}
