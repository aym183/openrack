//
//  CreateSales.swift
//  openrack
//
//  Created by Ayman Ali on 23/04/2023.
//

import SwiftUI

struct CreateSales: View {
    @StateObject var listingsViewModel = ListingViewModel()

    @State var listings = ListingViewModel().listings
//    var retrievedListings = UserDefaults.standard.data(forKey: "listings") //as? [Listing] ?? []
    @State var showingBottomSheet = false
//    var listingID: String
    var addStream = CreateDB()
//    var creatorView: Bool
    @State var itemSelected = false
    @State var preSelected: Listing?
    
    
    var body: some View {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Text("Sales").font(Font.system(size: 30)).fontWeight(.bold)
                    }
                    .padding(.top, 20).padding(.horizontal, 20).foregroundColor(.black)
                    
//                    List {
                    ScrollView {
                        //listingsViewModel.listings
                        ForEach((1...4), id: \.self) { sale in
//                                ListingRow(image: "tshirt", title: "This title", quantity: "5")
                                VStack {
                                    HStack {
                                        Text("Item").font(Font.system(size: 12))
                                        Spacer()
                                        Text("400 AED").font(Font.system(size: 12))
                                    }.padding([.horizontal, .top],10)
                                    
                                    Spacer()
                                    HStack {
                                        Text("Address XYZ - City - Country").font(Font.system(size: 14))
                                    }
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Text("Buyer: aym1302 | Ayman Ali | +447859234405").font(Font.system(size: 12))
                                        Spacer()
                                    }
                                    .padding([.horizontal, .bottom],10)
                                }
                            .frame(height: 100)
                            .border(.black, width: 2)
                            .padding(.horizontal, 20)
                            .padding(.top, 5)
                        }
                    }

//                    }
//                    .border(Color.black, width: 2)

                    Spacer()
                    
                }
            }
            .foregroundColor(.black)
            .fontWeight(.bold)
            .onAppear {
//                if let data = UserDefaults.standard.object(forKey: "listings") as? Data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let listingsDictionary = try decoder.decode([String: [Listing]].self, from: data)
//                        if listingsDictionary[listingID] == nil {
//                            listings = []
//                        } else {
//                            listings = listingsDictionary[listingID]!
//                        }
//                    } catch let error {
//                        print("Error decoding listings data: \(error.localizedDescription)")
//                    }
//                } else {
//                    // handle the case where there is no data for the "myListings" key
//                }
            }
    }
}

struct CreateSales_Previews: PreviewProvider {
    static var previews: some View {
        CreateSales()
    }
}
