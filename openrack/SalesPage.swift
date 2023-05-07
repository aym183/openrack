//
//  SalesPage.swift
//  openrack
//
//  Created by Ayman Ali on 30/04/2023.
//
import SwiftUI

struct SalesPage: View {
    @ObservedObject var readListing: ReadDB
    var body: some View {
        var noOfSales = readListing.creatorSales?.count ?? 0
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
                        ForEach(0..<noOfSales) { index in
                            
                            VStack {
                                HStack {
                                    Text(String(describing: readListing.creatorSales![index]["item"]!))
                                    Spacer()
                                    Text("Buyer: \(String(describing: readListing.creatorSales![index]["buyer"]!))").font(Font.system(size: 14))
                                    
                                }
                                .foregroundColor(.black)
                                .padding(.top,5)
                                
                                Spacer()
                                
                                HStack {
                                    Text("\(String(describing: readListing.creatorSales![index]["full_name"]!)), \(String(describing: readListing.creatorSales![index]["house_number"]!)), \(String(describing: readListing.creatorSales![index]["street"]!)), \(String(describing: readListing.creatorSales![index]["city"]!)), \(String(describing: readListing.creatorSales![index]["country"]!))").font(Font.system(size: 15)).multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                
                                Spacer()
                                
                                HStack {
                                    Text("Total: \(String(describing: readListing.creatorSales![index]["order_total"]!))").font(Font.system(size: 14))
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
//
//struct SalesPage_Previews: PreviewProvider {
//    static var previews: some View {
//        SalesPage(sales: [])
//    }
//}
