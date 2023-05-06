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
    
    @Published var userOrders: [[String: Any]]? = []
    @Published var creatorSales: [[String: Any]]? = nil
    @Published var creatorShows: [[String: Any]]? = []
    @Published var viewerShows: [[String: Any]]? = []
    @Published var viewerScheduledShows: [[String: Any]]? = []
    @Published var title: String? = nil
    @Published var type: String? = nil
    @Published var price: String? = nil
    @Published var timer: String? = nil
    @Published var highest_bid: String? = nil
    @Published var current_bidder: String? = nil
    @Published var isSold: Bool? = nil
    @Published var address: [String: String]? = nil
    @Published var cardDetails: [String: String]? = nil
    @Published var comments: [[String: String]]? = []
//    @Published var is_timer: Bool? = false
    
    func getUserDefaults() {
        @AppStorage("username") var userName: String = ""
        @AppStorage("full_name") var fullName: String = ""
//        @AppStorage("email") var userEmail: String = ""
        @AppStorage("stripe_customer_id") var stripeCustomerID: String = ""
        @AppStorage("phone_number") var phoneNumber: String = ""
        
        let db = Firestore.firestore()
        let ref = db.collection("users")
        
        ref.whereField("username", isEqualTo: userName)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getUsername: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
//                        UserDefaults.standard.set(String(describing:document.data()["email"]!), forKey: "email")
                        UserDefaults.standard.set(String(describing:document.data()["full_name"]!), forKey: "full_name")
                        UserDefaults.standard.set(String(describing:document.data()["phone_number"]!), forKey: "phone_number")
                        UserDefaults.standard.set(String(describing:document.data()["stripe_customer_id"]), forKey: "stripe_customer_id")
                        UserDefaults.standard.set(String(describing:document.data()["stripe_payment_method"]), forKey: "stripe_payment_method")
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
                        self.address = ["full_name": document.data()["full_name"], "house_number": document.data()["house_number"], "street": document.data()["street"] , "city": document.data()["city"], "country": document.data()["country"]] as? [String: String]
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
//                UserDefaults.standard.set(userShows, forKey: "shows")
                self.creatorShows = userShows
            }
        
    }
    
    func getCreatorSales(listingID: String) {
        
        let db = Firestore.firestore()
        let ref = db.collection("sales")
        var sales = UserDefaults.standard.array(forKey: "myKey") as? [[String:Any]] ?? []
        
        ref.whereField(FieldPath.documentID(), isEqualTo: listingID)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getCreatorSales: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        for documentData in document.data().values {
                            if let valueDict = documentData as? [String: Any] {
                                sales.append(["buyer": valueDict["buyer"]!, "city": valueDict["city"]!, "full_name": valueDict["full_name"]!, "house_number": valueDict["house_number"]!, "item": valueDict["item"]!, "order_total": valueDict["order_total"]!, "seller": valueDict["seller"]!, "street": valueDict["street"]!, "country": valueDict["country"]!,])
                            }
                        }
//                        .values
                    }
//                    print(snapshot!.documents)
//                    let document = snapshot!.documents
//                    let documentData = document.data()
//                    for value in documentData.values {
//                        if let valueDict = value as? [String: Any] {
//                            sales.append(["buyer": valueDict["buyer"]!, "city": valueDict["city"]!, "full_name": valueDict["full_name"]!, "house_number": valueDict["house_number"]!, "item": valueDict["item"]!, "order_total": valueDict["order_total"]!, "seller": valueDict["seller"]!, "street": valueDict["street"]!, "country": valueDict["country"]!,])
//                        }
//                    }
//                    for document in snapshot!.documents {
//                        document.data()["full_name"]
//                        .values
//                        print(document.data().values["full_name"])
//                    }
                }
                print("Sales are \(sales)")
                self.creatorSales = sales
            }
    }
    
    func getViewerLiveShows() {
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
                self.viewerShows = viewerShows
//                UserDefaults.standard.set(viewerShows, forKey: "viewer_shows")
            }
    }
    
    func getViewerScheduledShows() {
        @AppStorage("username") var userName: String = ""
        var scheduledShows = UserDefaults.standard.array(forKey: "myViewerKey2") as? [[String:Any]] ?? []
        
        let db = Firestore.firestore()
        let ref = db.collection("shows")
        ref.whereField("created_by", isNotEqualTo: userName)
            .whereField("status", isEqualTo: "Created")
        
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting email in getViewerShows: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        scheduledShows.append(document.data())
                    }
                }
//                UserDefaults.standard.set(viewerScheduledShows, forKey: "viewer_scheduled_shows")
                self.viewerScheduledShows = scheduledShows
                print("We have scheduled shows")

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
                                       
                                       listings.append(Listing(image: "tshirt.fill", title: dictValue!["name"]!, quantity: dictValue!["quantity"]!, price: dictValue!["price"]!, type: dictValue!["type"]!))
//                                       ImageSelector().getImage(category: dictValue!["category"]!)
               
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
    
    func getUserOrders() {
        @AppStorage("username") var userName: String = ""
        var orders = UserDefaults.standard.array(forKey: "myViewerKey") as? [[String:Any]] ?? []
        
        let db = Firestore.firestore()
        let ref = db.collection("orders")
        ref.whereField("buyer", isEqualTo: userName)
        
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting orders: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        orders.append(document.data())
                    }
                }
                self.userOrders = orders
                print(self.userOrders)
            }
    }
    
    
    // ------------------------- Realtime Database ---------------------------------
    
    
    func getListingSelected(listingID: String) {
        let titleDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("title")
        let priceDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("price")
        let typeDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("type")
        let isSoldDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("is_sold")
        let currentBidderDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("current_bidder")
        let highestBidDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("highest_bid")
        let timerDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("timer")
        let commentDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("comments")
        
        Database.database().isPersistenceEnabled = true
        commentDB.keepSynced(true)
        highestBidDB.keepSynced(true)
        currentBidderDB.keepSynced(true)
        titleDB.keepSynced(true)
        priceDB.keepSynced(true)
        typeDB.keepSynced(true)
        
        var temp_comments: [[String: String]] = []
//        let istimerDB = Database.database().reference().child("shows").child(listingID).child("selectedListing").child("is_timer")
        
        titleDB.observe(.value) { snapshot in
            if let title_text = snapshot.value as? String {
                    self.title = title_text
            }
        }
        
        typeDB.observe(.value) { snapshot in
            if let type_text = snapshot.value as? String {
                    self.type = type_text
            }
        }
        
        priceDB.observe(.value) { snapshot in
            if let price_text = snapshot.value as? String {
                    self.price = price_text
            }
        }
        
        
        commentDB.observe(.value) { snapshot in
            
            if snapshot.value != nil {
                for (index, child) in snapshot.children.enumerated() {
                    if index >= self.comments!.count {
                        guard let commentSnapshot = child as? DataSnapshot else { continue }
                        let commentKey = commentSnapshot.key
                        let commentData = commentSnapshot.value as? [String: Any]
                        let username = commentData?["username"] as? String ?? ""
                        let comment = commentData?["comment"] as? String ?? ""
                        
                        let containsValueXAndY = self.comments!.contains { dict in
                            dict["username"] == username && dict["comment"] == comment
                        }
                        
                        self.comments?.append(["username": username, "comment": comment])
                    }
                    }
                
//                self.comments = temp_comments
//                temp_comments = []
            }
//            if let comments_value = snapshot.value as? [[String: String]] {
//                    self.comments = comments_value
//            }
        }
        
        isSoldDB.observe(.value) { snapshot in
            if let is_sold = snapshot.value as? Bool {
                    self.isSold = is_sold
            }
        }
        
//        istimerDB.observe(.value) { snapshot in
//            if let is_timer = snapshot.value as? Bool {
//                    self.is_timer = is_timer
//            }
//        }
        currentBidderDB.observe(.value) { snapshot in
            if let current_bidder_value = snapshot.value as? String {
                    self.current_bidder = current_bidder_value
            }
        }
        
        highestBidDB.observe(.value) { snapshot in
            if let highest_bid_value = snapshot.value as? String {
                    self.highest_bid = highest_bid_value
            }
        }
        
        timerDB.observe(.value) { snapshot in
            if let timer_value = snapshot.value as? String {
                    self.timer = timer_value
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
