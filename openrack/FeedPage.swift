//
//  HomePage.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct FeedPage: View {
    //    var player = AVPlayer(url: URL(string: "https://stream.mux.com/P00XyP51P6wIgER8mJZiu2nGl6DVvFjjYzG902ZbuOpmQ.m3u8")!)
    @State var showingBottomSheet = false
    @State var isShowingNextView = false
    @State var isBookmarked = false
    var columns: [GridItem] = [
        GridItem(.flexible() , spacing: 10, alignment: nil),
        GridItem(.flexible() , spacing: nil, alignment: nil)
    ]
    var body: some View {
        NavigationStack {
            VStack {
                CustomNavbarView()
                Spacer()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        // Change to length of response array
                        ForEach(0..<6) { index in
                            ZStack{
                                Color.white
                                VStack (alignment: .leading){
                                    
                                    HStack {
                                        Image(systemName: "livephoto").foregroundColor(Color.red)
                                        Text("Live")
                                            .fontWeight(.semibold).padding(.leading, -6)
                                        Spacer()
                                        Button(action: {isBookmarked.toggle()}) {
                                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark").foregroundColor(Color("Primary_color"))
                                        }
                                        
                                    }
                                    .padding(.horizontal, 0)
                                    .frame(width: 155)
                                    
                                    Spacer()
                                    Text("Content").padding(.leading, 3)
                                }
                                .padding(.vertical, 10)
                                .frame(width: 155)
                                
                            }
                            .frame(height: 200)
                            .cornerRadius(20.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.top)
                
                
                HStack {
                    Button(action: { showingBottomSheet.toggle() }, label: {
                        Text("+")
                            .font(.system(.largeTitle)).frame(width: 50, height: 40)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
                    .background(Color("Primary_color"))
                    .cornerRadius(38.5)
                    .padding(.bottom,30)
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
//
                }
                
            }
            .background(Color("Secondary_color"))
            .sheet(isPresented: $showingBottomSheet) {
                StreamBottomSheet(showingBottomSheet: $showingBottomSheet, isShowingNextView: $isShowingNextView)
                    .presentationDetents([.height(200)])
            }
            .navigationDestination(isPresented: $isShowingNextView) {
                ScheduleStream().navigationBarHidden(true)
            }
        }
        
    }
}
        
//        VideoPlayer(player: player)
//                   .onAppear() {
//                       player.play()
//                       createLiveStream()
//                   }

    
//    func createLiveStream() {
//        // Set up the request URL and parameters
//        let url = URL(string: "https://api.mux.com/video/v1/live-streams")!
//        var request = URLRequest(url: url)
//        let muxTokenID = "a0cb25b9-df73-40b5-acc4-e214297afbea"
//        let muxTokenSecret = "oTZ5J9/aFCGR44YBvkO+GjOa16AfCs595nDMom3O5TO+Mk/VSUz+4a4Ts+ZhwBo6YhOs7LUQOsN"
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Set up the request body
//        let bodyData = """
//            {
//                "playback_policy": "public",
//                "new_asset_settings": {
//                    "playback_policy": "public"
//                }
//            }
//            """.data(using: .utf8)!
//        request.httpBody = bodyData
//
//        // Set up the authentication header
//        let token = "\(muxTokenID):\(muxTokenSecret)".data(using: .utf8)!.base64EncodedString()
//        request.setValue("Basic \(token)", forHTTPHeaderField: "Authorization")
//
//        // Make the API call
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//            }
//            if let data = data {
//                if let responseString = String(data: data, encoding: .utf8) {
//                    print("Response: \(responseString)")
//                }
//                else {
//                    print("Error: Could not decode response data")
//                }
//            }
//        }.resume()
//    }




struct FeedPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedPage()
    }
}
