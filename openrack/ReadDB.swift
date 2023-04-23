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
    
    @Published var title: String? = nil
    @Published var price: String? = nil
    @Published var address: [String: String]? = nil
    @Published var cardDetails: [String: String]? = nil
    
    func getUserDefaults() {
        @AppStorage("username") var userName: String = ""
        @AppStorage("full_name") var fullName: String = ""
        @AppStorage("email") var userEmail: String = ""
        @AppStorage("stripe_customer_id") var stripeCustomerID: String = ""
        
        let db = Firestore.firestore()
        let ref = db.collection("users")
        
        ref.whereField("email", isEqualTo: userEmail)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getUsername: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        UserDefaults.standard.set(String(describing:document.data()["username"]!), forKey: "username")
                        UserDefaults.standard.set(String(describing:document.data()["full_name"]!), forKey: "full_name")
                        UserDefaults.standard.set(String(describing:document.data()["stripe_customer_id"]!), forKey: "stripe_customer_id")
                        UserDefaults.standard.set(String(describing:document.data()["stripe_payment_method"]!), forKey: "stripe_payment_method")
                    }
                }
            }
    }
    
    func getAddress() {
        @AppStorage("username") var userName: String = ""
        
        let db = Firestore.firestore()
        let ref = db.collection("users")
        
        ref.whereField("username", isEqualTo: userName)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getAddress: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        self.address = ["full_name": document.data()["full_name"], "address": document.data()["address"], "city": document.data()["city"], "postal_code": document.data()["postal_code"]] as? [String: String]
                    }
                }
            }
    }
    
    func getCardDetails() {
        @AppStorage("username") var userName: String = ""
        
        let db = Firestore.firestore()
        let ref = db.collection("users")
        
        ref.whereField("username", isEqualTo: userName)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getCardDetails: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        if (document.data()["card_brand"] != nil) && ((document.data()["last_four"]) != nil) {
                            self.cardDetails = ["card_brand": String(describing:document.data()["card_brand"]!), "last_four": String(describing: document.data()["last_four"]!)]
                        } else {
                            self.cardDetails = nil
                        }
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
            .whereField("status", isEqualTo: "Live")
        
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
                        UserDefaults.standard.set(String(describing:document.data()["stream_key"]!), forKey: "stream_key")
                    }
                }
            }
    }
    
    func getListingIDs() {
        @AppStorage("username") var userName: String = ""
        let db = Firestore.firestore()
        let ref = db.collection("shows")
        var listingIDs: [String] = []
        
        ref.whereField("created_by", isEqualTo: userName)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getListingIDs: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        listingIDs.append(document.data()["listings"]! as! String)
                    }
                }
                UserDefaults.standard.set(listingIDs, forKey: "listing_ids")
            }
    }
    func getListings() {
         
        var listingIDs = UserDefaults.standard.array(forKey: "listing_ids") as? [String]
        var listings: [Listing] = []
        var dictValue: [String: String]?
        var output: [String: [Listing]] = [:]
        
//        var listing: [String]
        let db = Firestore.firestore()
        
        if listingIDs == nil {
            print("Ignore as no Listing IDs")
        } else{
            for (index,id) in listingIDs!.enumerated() {
                db.collection("listings").whereField(FieldPath.documentID(), isEqualTo: id).getDocuments(source: .default) { (querySnapshot, error) in
                           if let error = error {
                                   print("Error getting document: \(error.localizedDescription)")
                               } else if let snapshot = querySnapshot, !snapshot.isEmpty {
                                   let document = snapshot.documents[0]
                                   let documentData = document.data()
                                   
                                   listings = []
                                   for value in documentData.values {
                                       
                                       dictValue = value as! [String: String]
                                       
                                       listings.append(Listing(image: ImageSelector().getImage(category: dictValue!["category"]!), title: dictValue!["name"]!, quantity: dictValue!["quantity"]!, price: dictValue!["price"]!, type: dictValue!["type"]!))
               
    //                                   getListings.append(listing!)
    //                        ListingViewModel().listings.append(listing!)
                                   }
                                   output[id] = listings
                                   
                               } else {
                                   print("Document does not exist")
                               }
                    if index == 0 {
                        let encoder = JSONEncoder()
                        if let encodedListings = try? encoder.encode(output) {
                            UserDefaults.standard.set(encodedListings, forKey: "listings")
                        }
                    }
                        
                       }
            }
        }
    }
    
    // ------------------------- Realtime Database ---------------------------------
    
    func getListingSelected(listingID: String) {
        let titleDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("title")
        let priceDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("price")
        
        titleDB.observe(.value) { snapshot in
            if let title_text = snapshot.value as? String {
                    self.title = title_text
                }
        }
        
        priceDB.observe(.value) { snapshot in
            if let price_text = snapshot.value as? String {
                    self.price = price_text
                }
        }
        
    }
    
}
        
        /////////////////
        
//        let collectionRef = db.collection("listings")
//
//        collectionRef.getDocuments { snapshot, error in
//                        if let error = error {
//                            print("Error getting documents in getListings: \(error.localizedDescription)")
//                        } else {
//                            guard let documentsSnapshot = snapshot else { return }
//
//                            for document in documentsSnapshot.documents {
//                                listings[document.documentID] = document.data()
////                                print("\(document.documentID ) has data: \(document.data())")
//                            }
////                            print(listings)
//                            UserDefaults.standard.set(listings, forKey: "listings")
//                        }
//                    }

//if let error = error {
//    print("Error getting ReadListings: \(error.localizedDescription)")
//} else if let snapshot = querySnapshot, !snapshot.isEmpty {
//    let document = snapshot.documents[0]
//    let documentData = document.data()
//    //                print(documentData)
//    for values in documentData.values {
//        Listings.append(Listing(image: ImageSelector().getImage(category: documentData[3]), title: documentData[0], quantity: documentData[2]))
//    }
//} else {
//    print("Document does not exist")
//}
