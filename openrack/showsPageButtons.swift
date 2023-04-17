//
//  showsPageButtons.swift
//  openrack
//
//  Created by Ayman Ali on 16/04/2023.
//

import SwiftUI

struct ShowsPageButtons: View {
        var name: String!
        var stream_key: String!
        var stream_id: String!
        var liveStreamID: String!
        var listingID: String!
        @State var streamStarted = false
        @State var listingStarted = false
        @State var listings = ListingViewModel().listings
//        var retrievedListings = UserDefaults.standard.object(forKey: "listings")
    
        var body: some View {
            HStack {
                Button(action: {
                    ReadDB().getStreamKey(liveStreamID: stream_id)
                    streamStarted.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black)
                        .frame(width: 85, height: 30)
                        .overlay(
                            Text("Start Streaming").font(Font.system(size: 8)).fontWeight(.bold).foregroundColor(.white)
                        )
                }
                .padding(.leading, 5)
                .navigationDestination(isPresented: $streamStarted) {
                    CreatorShow(streamName: name, streamKey: stream_key, liveStreamID: liveStreamID, listingID: listingID).navigationBarHidden(true)
                }

                
                Button(action: {
//                    if let myDictionary = UserDefaults.standard.object(forKey: "listings") {
                    listingStarted.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black)
                        .frame(width: 70, height: 30)
                        .overlay(
                            HStack{
                                Image(systemName: "tshirt.fill").font(Font.system(size: 8)).padding(.trailing, -5)
                                Text("Listings").font(Font.system(size: 8)).fontWeight(.bold)
                            }
                                .foregroundColor(.white)
                        )
                }
                .navigationDestination(isPresented: $listingStarted) {
                    CreateListings(listingID: listingID)
                }
                
                Button(action: {}) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
                    .frame(width: 70, height: 30)
                    .overlay(
                        HStack{
                            Image(systemName: "link").font(Font.system(size: 8)).padding(.trailing, -5)
                            Text("Copy Link").font(Font.system(size: 8)).fontWeight(.bold)
                        }
                            .foregroundColor(.white)
                    )
                }
                
                    
                Button(action: { print(index) }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: 85, height: 26)
                    .overlay(
                        Text("Cancel Stream").font(Font.system(size: 8)).fontWeight(.bold).foregroundColor(.red)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                            .frame(width: 88.5, height: 30)
                    )
                }

                Spacer()
            }
            .padding(.top, 0)
            .foregroundColor(.black)
        }
}

struct showsPageButtons_Previews: PreviewProvider {
    static var previews: some View {
        ShowsPageButtons()
    }
}
