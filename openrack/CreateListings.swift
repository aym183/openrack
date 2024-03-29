//
//  CreateListings.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//
import SwiftUI
import Foundation

struct CreateListings: View {
    @StateObject var listingsViewModel = ListingViewModel()
    @State var listings = ListingViewModel().listings
    @State var showingBottomSheet = false
    var listingID: String
    var addStream = CreateDB()
    var creatorView: Bool
    @State var itemSelected = false
    @State var preSelected: Listing?
    @Binding var listingSelected: Listing
    
    var body: some View {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Listings").font(Font.system(size: 30)).fontWeight(.bold)
                        Spacer()
                        
                        if creatorView {
                            Text("Select One").font(Font.system(size: 15)).fontWeight(.semibold).opacity(0.7)
                        }
                    }
                    .padding(.top, 20).padding(.horizontal).foregroundColor(.black)
                    
                    ScrollView {
                        ForEach(listings) { listing in
                            Button(action: {
                                if creatorView {
                                    itemSelected.toggle()
                                    preSelected = listing
                                    UpdateDB().updateListingSelected(listingID: listingID, listing: listing)
                                }
                            }) {
                                ListingRow(image: listing.image, title: listing.title, quantity: listing.quantity)
                            }
                            .padding(.leading, 20)
                            .disabled(creatorView ? false : true)
                        }
                        .frame(width: 380)
                    }

                    Spacer()
                    
                    HStack{
                        if itemSelected {
                            Button(action: {
                                listingSelected = preSelected!
                                if preSelected!.type == "Auction" {
                                    UpdateDB().updateTimer(listingID: listingID, start_time: "0:30", viewer_side: false)
                                }
                            }) {
                                    HStack { Text("Start Selling").font(.title3) }
                            }
                            .frame(width: 360, height: 50)
                            .background(Color("Primary_color"))
                            .foregroundColor(.white)
                            .border(Color.black, width: 2)
                            .padding(.bottom, 10)
                            
                        } else {
                            Button(action: { showingBottomSheet.toggle() }, label: {
                                    Text("+")
                                        .font(.system(.largeTitle)).frame(width: 50, height: 40)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 7)
                            })
                            .foregroundColor(.black)
                            .background(Color("Primary_color"))
                            .cornerRadius(38.5)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                        }
                    }
                    .frame(width: 400, height: 50)
                    .sheet(isPresented: $showingBottomSheet) {
                        ListingsForm(listings: $listings, showingBottomSheet: $showingBottomSheet, listingID: listingID)
                            .presentationDetents([.height(750)])
                    }
                }
            }
            .onAppear {
                if let data = UserDefaults.standard.object(forKey: "listings") as? Data {
                    do {
                        let decoder = JSONDecoder()
                        let listingsDictionary = try decoder.decode([String: [Listing]].self, from: data)
                        if listingsDictionary[listingID] == nil {
                            listings = []
                        } else {
                            listings = listingsDictionary[listingID]!
                        }
                    } catch let error {
                        print("Error decoding listings data: \(error.localizedDescription)")
                    }
                }
            }
    }
}

struct ListingRow: View {
    let image: String
    let title: String
    let quantity: String
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(title)
                .fontWeight(.medium)
            Spacer()
            Text("Stock: \(quantity)").opacity(0.7)
        }
        .frame(height: 50)
        .foregroundColor(.black)
    }
}
