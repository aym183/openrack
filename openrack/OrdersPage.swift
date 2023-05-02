//
//  OrdersPage.swift
//  openrack
//
//  Created by Ayman Ali on 29/04/2023.
//
import SwiftUI

struct OrdersPage: View {
    @State var orders: [[String: Any]]
    
    var body: some View {
        var noOfOrders = orders.count ?? 0
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 20
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Orders").font(Font.system(size: 30)).fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top, 20).padding(.horizontal).foregroundColor(.black)
                    
                    ScrollView {
                        //listingsViewModel.listings
                        ForEach(0..<noOfOrders) { index in
                            
                            HStack {
                                
                                RoundedRectangle(cornerRadius: 30)
                                //                                .fill(ColorSelector().getStatusColor(status: statusColor))
                                    .fill(ColorSelector().getOrderStatusColor(status: String(describing: orders[index]["status"]!)))
                                    .frame(width: 70, height: 25)
                                    .overlay(
                                        Text(String(describing: orders[index]["status"]!)).textCase(.uppercase).font(Font.system(size: 8)).fontWeight(.bold).foregroundColor(.white)
                                    )
                                    .padding(.trailing, 5)
                                
                                Text(String(describing: orders[index]["item"]!)).font(Font.system(size: 16)).fontWeight(.bold).foregroundColor(.black)
                                
                                Spacer()
                                Text(String(describing: orders[index]["order_total"]!)).font(Font.system(size: 10)).fontWeight(.bold).foregroundColor(.black)
                                
                            }
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .padding(.horizontal).padding(.top,5)
                            
                        }
                        .frame(width: varWidth)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct OrdersPage_Previews: PreviewProvider {
    static var previews: some View {
        OrdersPage(orders: [])
    }
}
