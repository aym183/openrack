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
//    var retrievedListings = UserDefaults.standard.data(forKey: "listings") //as? [Listing] ?? []
    @State var showingBottomSheet = false
    var listingID: String
    var addStream = CreateDB()
//    var isBothTextFieldsEmpty: Bool {
//        return streamName.isEmpty || streamDescription.isEmpty
//    }
    
    // On appear, append read data from db in form of Listings to listings
    
//    init() {
////        retrievedListings = UserDefaults.standard.array(forKey: "listings") as? [Listing] ?? []
//
//    }
    
    var body: some View {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("Listings").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20).foregroundColor(.black)
                    
//                    List {
                    ScrollView {
                        //listingsViewModel.listings
                        ForEach(listings) { listing in
                            Button(action: {
                                print("You clicked \(listing.title)")
                            }) {
                                ListingRow(image: listing.image, title: listing.title, quantity: listing.quantity)
                            }
                        }
                        .frame(width: 360)
                    }

//                    }
//                    .border(Color.black, width: 2)

                    Spacer()
                    
                    HStack{
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
                    .frame(width: 360, height: 50)
                    .sheet(isPresented: $showingBottomSheet) {
                        ListingsForm(listings: $listings, showingBottomSheet: $showingBottomSheet, listingID: listingID)
                            .presentationDetents([.height(750)])
                    }
                    
                    
//                    Button(action: {
//                    }) {
//                        HStack { Text("Done").font(.title3) }
//                    }
//                    .frame(width: 360, height: 50)
//                    .background(Color("Primary_color"))
//                    .foregroundColor(.white)
//                    .border(Color.black, width: 2)
//                    .padding(.vertical)
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
                } else {
                    // handle the case where there is no data for the "myListings" key
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

//struct CreateListings_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateListings(listingID : "Test")
//    }
//}
