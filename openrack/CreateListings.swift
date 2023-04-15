//
//  CreateListings.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import SwiftUI

struct CreateListings: View {
    @StateObject var listingsViewModel = ListingViewModel()
    @State var showingBottomSheet = false
    var listingID: String
    var addStream = CreateDB()
//    var isBothTextFieldsEmpty: Bool {
//        return streamName.isEmpty || streamDescription.isEmpty
//    }
    
    var body: some View {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("Listings").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
                    List {
                        ForEach(listingsViewModel.listings) { listing in
                            
                        }
                    }
                    .frame(width: 360)
                    .border(Color.black, width: 2)
                    
                    Spacer()
                    
                    HStack{
                        Button(action: { showingBottomSheet.toggle() }, label: {
                                Text("+")
                                    .font(.system(.largeTitle)).frame(width: 50, height: 40)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 7)
                            })
                            .background(Color("Primary_color"))
                            .cornerRadius(38.5)
                            .padding(.bottom, -15)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                    .frame(width: 360, height: 50)
                    .sheet(isPresented: $showingBottomSheet) {
                        ListingsForm(showingBottomSheet: $showingBottomSheet, listingID: listingID)
                            .presentationDetents([.height(750)])
                    }
                    
                    Button(action: {
                    }) {
                        HStack { Text("Done").font(.title3) }
                    }
                    .frame(width: 360, height: 50)
                    .background(Color("Primary_color"))
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .padding(.vertical)
                }
            }
            .foregroundColor(.black)
    }
}

struct CreateListings_Previews: PreviewProvider {
    static var previews: some View {
        CreateListings(listingID : "Test")
    }
}
