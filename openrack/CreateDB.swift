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
    
    func addShow(name: String, description: String, date: String, livestream_id: String, playback_id: String, stream_key: String) {
        let db = Firestore.firestore()
        let ref = db.collection("shows")
        let group = DispatchGroup()
        var docRef = ref.document()
        @AppStorage("username") var userName: String = ""

        let data: [String: Any] = [
            "date_created": miscData.getPresentDateTime(),
            "date_scheduled": date,
            "created_by": userName,
            "name": name,
            "listings": docRef.documentID,
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
}
