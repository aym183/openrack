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
    var miscData = MiscData()
    var getUsername = ReadDB()
    
    func addUser(email: String, username: String, fullName: String) {
        let db = Firestore.firestore()
        let ref = db.collection("users")
        let data: [String: Any] = [
            "date_created": miscData.getPresentDateTime(),
            "last_updated": miscData.getPresentDateTime(),
            "phone_number": "",
            "email": email,
            "username": username,
            "full_name": fullName,
            "stripe_customer_id": "",
            "stripe_payment_method": ""
        ]
        
        ref.addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("User added")
                UserDefaults.standard.set(username, forKey: "username")
            }
        }
    }
    
    func addPhoneUser(phoneNumber: String, username: String, fullName: String) {
        let db = Firestore.firestore()
        let ref = db.collection("users")
        let data: [String: Any] = [
            "date_created": miscData.getPresentDateTime(),
            "last_updated": miscData.getPresentDateTime(),
            "phone_number": phoneNumber,
            "username": username,
            "email": "",
            "full_name": fullName,
            "stripe_customer_id": "",
            "stripe_payment_method": ""
        ]
        
        ref.addDocument(data: data) { error in
            if let error = error {
                print("Error adding addPhoneUser: \(error.localizedDescription)")
            } else {
                print("Phone User added")
            }
        }
    }
    
    func createStripeCustomer(name: String, email: String) {
        let url = URL(string: "https://foul-checkered-lettuce.glitch.me/create-customer")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try? JSONEncoder().encode(["name": name, "email": email])
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200
            else {
                return
            }
        }.resume()
    }
    
    func addShow(name: String, description: String, date: String, livestream_id: String, playback_id: String, stream_key: String) {
        let db = Firestore.firestore()
        let ref = db.collection("shows")
        let group = DispatchGroup()
        var docRef = ref.document().documentID
        @AppStorage("username") var userName: String = ""
        let data: [String: Any] = [
            "date_created": miscData.getPresentDateTime(),
            "date_scheduled": date,
            "created_by": userName,
            "name": name,
            "listings": docRef,
            "sales": docRef,
            "description": description,
            "status": "Created",
            "livestream_id": livestream_id,
            "playback_id": playback_id,
            "stream_key": stream_key
        ]
        group.enter()
        DispatchQueue.global(qos: .background).async {
            ref.addDocument(data: data) { error in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                } else {
                    print("Show added")
                    CreateDB().addcurrentListing(listingID: docRef)
                }
            }
            group.leave()
        }
        group.wait()
        ReadDB().getCreatorShows()
        ReadDB().getViewerLiveShows()
        ReadDB().getViewerScheduledShows()
        ReadDB().getListingIDs()
        
    }
    
    func addListings(listing: [String: String], docRef: String){
        let db = Firestore.firestore()
        let ref = db.collection("listings")
        var docID = ref.document(docRef)
        var presentDateTime = miscData.getPresentDateTime()
        var documentData = [String: Any]()
        var fieldID = ref.document()
        documentData[fieldID.documentID] = ["name": listing["name"], "description": listing["description"], "quantity": listing["quantity"], "price": listing["price"], "type": listing["type"], "date_created": presentDateTime]
        
        docID.setData(documentData) { error in
            if let error = error {
                print("Error adding listing: \(error.localizedDescription)")
            } else {
                print("Document added successfully!")
                ReadDB().getListings()
            }
        }
    }
    
    func addUserOrders(item: String, purchase_price: String, buyer: String) {
        @AppStorage("username") var userName: String = ""
        let db = Firestore.firestore()
        let ref = db.collection("orders")
        let data: [String: Any] = [
            "item": item,
            "order_total": "\(purchase_price) AED",
            "buyer": userName,
            "purchased_at": miscData.getPresentDateTime(),
            "status": "Processing"
        ]
        
        DispatchQueue.global(qos: .background).async {
            ref.addDocument(data: data) { error in
                if let error = error {
                    print("Error adding order: \(error.localizedDescription)")
                } else {
                    print("Order added")
                }
            }
        }
    }
    
    func addCreatorSales(item: String, purchase_price: String, seller: String, address: [String: String], listingID: String) {
        @AppStorage("username") var userName: String = ""
        let db = Firestore.firestore()
        let ref = db.collection("sales")
        var documentData = [String: Any]()
        var docID = ref.document(listingID)
        var fieldID = ref.document()
        
        documentData[fieldID.documentID] = [
            "item": item,
            "order_total": "\(purchase_price) AED",
            "buyer": userName,
            "seller": seller,
            "full_name": address["full_name"],
            "house_number": address["house_number"],
            "street": address["street"],
            "city": address["city"],
            "country": address["country"],
            "purchased_at": miscData.getPresentDateTime()
        ]
        
        DispatchQueue.global(qos: .background).async {
            docID.setData(documentData) { error in
                if let error = error {
                    print("Error adding sales: \(error.localizedDescription)")
                } else {
                    print("Sales added")
                }
            }
        }
    }
    
    func createLiveStream(completion: @escaping (Result<[String], Error>) -> Void) {
            // Set up the request URL and parameters
            let url = URL(string: "https://api.mux.com/video/v1/live-streams")!
            var request = URLRequest(url: url)
            let muxTokenID = "a0cb25b9-df73-40b5-acc4-e214297afbea"
            let muxTokenSecret = "secret"
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            var responseArray = Array<String>()
    
            let bodyData = """
                {
                    "playback_policy": "public",
                    "new_asset_settings": {
                        "playback_policy": "public"
                    }
                }
                """.data(using: .utf8)!
            request.httpBody = bodyData
            let token = "\(muxTokenID):\(muxTokenSecret)".data(using: .utf8)!.base64EncodedString()
            request.setValue("Basic \(token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error in createLiveStream: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                            completion(.failure(NSError(domain: "APIError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data returned from API"])))
                            return
                }
                do {
                        let jsonString = String(data: data, encoding: .utf8)
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let data = json["data"] as? [String: Any] {
                                if let id = data["id"] as? String {
                                    responseArray.append(id)
                                }
                                if let playbackIds = data["playback_ids"] as? [[String: Any]], let playbackId = playbackIds.first, let playbackIdValue = playbackId["id"] as? String {
                                    responseArray.append(playbackIdValue)
                                }
                                if let streamKey = data["stream_key"] as? String {
                                    responseArray.append(streamKey)
                                }
                                completion(.success(responseArray))
                        } else {
                            completion(.failure(NSError(domain: "APIError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON response"])))
                        }
                } catch {
                        completion(.failure(error))
                }
            }.resume()
        }
    
    // ------------------------- Realtime Database ---------------------------------
    
    func addcurrentListing(listingID: String) {
        let showsRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
        showsRef.child("title").setValue("")
        showsRef.child("price").setValue("")
        showsRef.child("type").setValue("")
        showsRef.child("timer").setValue("")
        showsRef.child("highest_bid").setValue("")
        showsRef.child("current_bidder").setValue("")
        showsRef.child("is_sold").setValue(false)
        showsRef.child("comments").setValue("")
    }
}
