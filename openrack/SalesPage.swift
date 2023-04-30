//
//  SalesPage.swift
//  openrack
//
//  Created by Ayman Ali on 30/04/2023.
//

import SwiftUI

struct SalesPage: View {
    @State var sales: [[String: Any]]
    var body: some View {
        var noOfSales = sales.count ?? 0
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 30
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack {
                    
                    HStack {
                        Text("Sales").font(Font.system(size: 30)).fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top, 20).padding(.horizontal).foregroundColor(.black)
                    
                    ScrollView {
                        //listingsViewModel.listings
                        ForEach(0..<2) { index in
                            
                            VStack {
                                HStack {
                                    Text("White Air Force Ones")
                                    Spacer()
                                    Text("Buyer: aym1302").font(Font.system(size: 14))
                                    
                                }
                                .foregroundColor(.black)
                                .padding(.top,5)
                                
                                Spacer()
                                
                                HStack {
                                    Text("Ayman Ali, Apartment 508, Skyline Apartments, Dubai, United Arab Emirates").font(Font.system(size: 15)).multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Text("Total: 450 AED").font(Font.system(size: 14))
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 10).padding(.vertical, 5)
                            .frame(width: varWidth, height: 130)
                            .border(.black, width: 2)
                            .fontWeight(.semibold)
                            .background(.white)
                            .padding(.vertical, 5)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
}

struct SalesPage_Previews: PreviewProvider {
    static var previews: some View {
        SalesPage(sales: [])
    }
}
