//
//  showsPageButtons.swift
//  openrack
//
//  Created by Ayman Ali on 16/04/2023.
//
import SwiftUI

struct ShowsPageButtons: View {
//        var name: String!
//        var stream_key: String!
//        var stream_id: String!
//        var liveStreamID: String!
//        var listingID: String!
        var retrievedShow: [String: Any]!
        @State var streamStarted = false
        @State var listingStarted = false
        @State var salesStarted = false
        @State var listings = ListingViewModel().listings
        @State var listingSelected = Listing(image: "", title: "", quantity: "", price: "", type: "")
        @StateObject var readListing = ReadDB()
//        var retrievedListings = UserDefaults.standard.object(forKey: "listings")
    
        var body: some View {
            GeometryReader { geometry in
                var varWidth = geometry.size.width - 40
                
                HStack {
                    
                    if String(describing: retrievedShow["status"]!) != "Finished" {
                        
                        Button(action: {
                            ReadDB().getStreamKey(liveStreamID:  String(describing: retrievedShow["livestream_id"]!))
                            streamStarted.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.black)
                                .frame(width: 85, height: 30)
                                .overlay(
                                    Text("Start Streaming").font(Font.system(size: 8)).fontWeight(.bold).foregroundColor(.white)
                                )
                        }
                        .navigationDestination(isPresented: $streamStarted) {
                            CreatorShow(streamName: String(describing: retrievedShow["name"]!), streamKey: String(describing: retrievedShow["stream_key"]!), liveStreamID:  String(describing: retrievedShow["livestream_id"]!), listingID:  String(describing: retrievedShow["listings"]!), listingSelected: $listingSelected).navigationBarHidden(true)
                        }
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
                        CreateListings(listingID:  String(describing: retrievedShow["listings"]!), creatorView: false, listingSelected: $listingSelected)
                    }
                    
                    if String(describing: retrievedShow["status"]!) != "Finished" {
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
                                .frame(width: 81.5, height: 26)
                                .overlay(
                                    Text("Cancel Stream").font(Font.system(size: 8)).fontWeight(.bold).foregroundColor(.red)
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.black)
                                        .frame(width: 85, height: 30)
                                )
                        }
                    } else {
                        Button(action: { salesStarted.toggle() }) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.black)
                                .frame(width: 70, height: 30)
                                .overlay(
                                    HStack{
                                        Image(systemName: "dollarsign.circle").font(Font.system(size: 9)).padding(.trailing, -5)
                                        Text("Sales").font(Font.system(size: 9)).fontWeight(.bold)
                                    }
                                        .foregroundColor(.white)
                                )
                        }
                        .navigationDestination(isPresented: $salesStarted) {
                            SalesPage(sales: readListing.creatorSales!)
                        }
                    }
                }
                .frame(width: varWidth)
                .padding(.leading, 20.15)
                .foregroundColor(.black)
                .onAppear {
                    readListing.getCreatorSales(listingID: String(describing: retrievedShow["listings"]!))
                }
            }
        }
}

struct showsPageButtons_Previews: PreviewProvider {
    static var previews: some View {
        ShowsPageButtons()
    }
}
