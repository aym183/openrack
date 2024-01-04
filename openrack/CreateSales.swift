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
    @State var showingBottomSheet = false
    var addStream = CreateDB()
    @State var itemSelected = false
    @State var preSelected: Listing?
    
    var body: some View {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Sales").font(Font.system(size: 30)).fontWeight(.bold)
                        .padding(.top, 20).padding(.horizontal, 20).foregroundColor(.black)
                    ScrollView {
                        ForEach((1...4), id: \.self) { sale in
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
                            .background(.white)
                            .border(.black, width: 2)
                            .padding(.horizontal, 20)
                            .padding(.top, 5)
                        }
                    }
                    Spacer()
                }
            }
            .foregroundColor(.black)
            .fontWeight(.bold)
    }
}

struct CreateSales_Previews: PreviewProvider {
    static var previews: some View {
        CreateSales()
    }
}
