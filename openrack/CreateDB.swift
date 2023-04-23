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
            "email": email,
            "username": username,
            "full_name": fullName,
            "address": "",
            "city": "",
            "state": "",
            "postal_cod": "",
            "country": "",
            "stripe_customer_id": "",
            "stripe_payment_method": ""
        ]
        
        ref.addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("User added")
            }
            
        }
    }
    
    func createStripeCustomer(name: String, email: String) {
        print(" I am in the func ")
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
    
//    func createStripeCustomer(name: String, email: String, completion: @escaping (Result<String, Error>) -> Void) {
//        let url = URL(string: "https://api.stripe.com/v1/customers")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.setValue("Bearer sk_test_51LcPpgJ4NNUHuKH8i7Pu627HnZXwmCPugAZxzZDqk1wafKLhimkcaEz02yrfh6pe4kP2Y2TUtz4pBK03JtEzHsJM00zfXEHjWW:", forHTTPHeaderField: "Authorization")
//
//            let customerData = "name=\(name)&email=\(email)"
//            print(customerData)
//            request.httpBody = customerData.data(using: .utf8)
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//
//                guard let data = data else {
//                    completion(.failure(NSError(domain: "com.openrack.stripe", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned from server"])))
//                    return
//                }
//
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    if let customerID = json?["id"] as? String {
//                        completion(.success(customerID))
//                    } else {
//                        completion(.failure(NSError(domain: "com.yourapp.stripe", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse customer ID from response"])))
//                    }
//                } catch {
//                    completion(.failure(error))
//                    return
//                }
//            }
//            task.resume()
//    }
    
    
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
        ReadDB().getViewerShows()
        ReadDB().getListingIDs()
        
    }
    
    func addListings(listing: [String: String], docRef: String){
        let db = Firestore.firestore()
        let ref = db.collection("listings")
//        let count = Int(listing[2])
        var docID = ref.document(docRef)
        var presentDateTime = miscData.getPresentDateTime()
        
        var documentData = [String: Any]()
//        for _ in 0..<count! {
        var fieldID = ref.document()
        documentData[fieldID.documentID] = ["name": listing["name"], "description": listing["description"], "quantity": listing["quantity"], "category": listing["category"], "subcategory": listing["subcategory"], "price": listing["price"], "type": listing["type"], "date_created": presentDateTime]
//        }
        
        docID.setData(documentData) { error in
        if let error = error {
            print("Error adding listing: \(error.localizedDescription)")
        } else {
            print("Document added successfully!")
            ReadDB().getListings()
        }
                }
        
    }
    
    func createLiveStream(completion: @escaping (Result<[String], Error>) -> Void) {
            // Set up the request URL and parameters
            let url = URL(string: "https://api.mux.com/video/v1/live-streams")!
            var request = URLRequest(url: url)
            let muxTokenID = "a0cb25b9-df73-40b5-acc4-e214297afbea"
            let muxTokenSecret = "oTZ5J9/aFCGR44YBvkO+GjOa16AfCs595nDMom3O5TO+Mk/VSUz+4a4Ts+ZhwBo6YhOs7LUQOsN"
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            var responseArray = Array<String>()
    
            // Set up the request body
            let bodyData = """
                {
                    "playback_policy": "public",
                    "new_asset_settings": {
                        "playback_policy": "public"
                    }
                }
                """.data(using: .utf8)!
            request.httpBody = bodyData
    
            // Set up the authentication header
            let token = "\(muxTokenID):\(muxTokenSecret)".data(using: .utf8)!.base64EncodedString()
            request.setValue("Basic \(token)", forHTTPHeaderField: "Authorization")
    
            // Make the API call
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
//                if let data = data {
                    do {
                                // Convert the binary data into a String
                                let jsonString = String(data: data, encoding: .utf8)
                                
                                // Deserialize the JSON into a Swift object
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let data = json["data"] as? [String: Any] {
                                // Access the values for id, playback_ids, and stream_key
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
                                print("Error parsing JSON response: \(error.localizedDescription)")
                                completion(.failure(error))
                            }
//                }
            }.resume()
        }
    
    // ------------------------- Realtime Database ---------------------------------
    
    func addcurrentListing(listingID: String) {
        let showsRef = Database.database().reference().child("shows").child(listingID).child("selectedListing")
        showsRef.child("title").setValue("")
        showsRef.child("price").setValue("")
        showsRef.child("is_sold").setValue(false)
    }
    
    
}
