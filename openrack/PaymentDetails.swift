//
//  PaymentDetails.swift
//  openrack
//
//  Created by Ayman Ali on 18/04/2023.
//

import SwiftUI
import SPAlert

struct PaymentDetails: View {
    @Binding var showingPaySheet: Bool
    @Binding var isShowingPaymentsForm: Bool
    @Binding var isShowingAddressForm: Bool
    @StateObject var addressDetails = ReadDB()

    var body: some View {
        GeometryReader { geometry in
            var btnWidth = geometry.size.width - 40
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack(spacing: 20) {
                    Button(action: {
                        isShowingAddressForm.toggle()
                    }) {
                        HStack {
                            Image(systemName: "shippingbox.fill").padding(.trailing, 10).padding(.leading, 5)
                            VStack(alignment: .leading) {
                                Text("Shipping")
                                    .fontWeight(.bold).font(Font.system(size: 20)).padding(.top)
                                
                                if addressDetails.address == nil {
                                    Text("Please set your information here.")
                                        .fontWeight(.semibold).font(Font.system(size: 14)).multilineTextAlignment(.leading).padding(.top, 0)
                                } else {
                                    Text("\(addressDetails.address!["full_name"]!)\n\(addressDetails.address!["house_number"]!)\n\(addressDetails.address!["street"]!), \(addressDetails.address!["city"]!)")
                                        .fontWeight(.semibold).font(Font.system(size: 12)).multilineTextAlignment(.leading).padding(.top, 0)
                                }
                            }
                            Spacer()
                            Image(systemName: "pencil").font(Font.system(size: 25))
                        }
                        .padding(20).padding(.bottom)
                        .frame(width: btnWidth)
                        .background(Color("Primary_color")).cornerRadius(15)
                        .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                    }
                    .sheet(isPresented: $isShowingAddressForm) {
                        AddressForm(showingPaySheet: $showingPaySheet, isShowingAddressForm: $isShowingAddressForm).presentationDetents([.height(750)])
                    }
                    
                    Button(action: {
                        ReadServer().startCheckout { response in
                            
                            //                            print("Response in \(response)")
                            PaymentConfig.shared.paymentIntentClientSecret = response[0] //clientSecret
                            PaymentConfig.shared.paymentIntentID = response[1]
                            
                            //                            DispatchQueue.main.async {
                            isShowingPaymentsForm.toggle()
                            //                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "creditcard.fill").padding(.trailing, 10).padding(.leading, 5)
                            VStack(alignment: .leading) {
                                Text("Payment")
                                    .fontWeight(.bold).font(Font.system(size: 20)).padding(.top)
                                if addressDetails.cardDetails == nil {
                                    Text("Please input your payment info.")
                                        .fontWeight(.semibold).font(Font.system(size: 14)).padding(.top, 0)
                                } else {
                                    Text("\(addressDetails.cardDetails!["card_brand"]!) - \(addressDetails.cardDetails!["last_four"]!)").fontWeight(.semibold).font(Font.system(size: 12)).multilineTextAlignment(.leading).padding(.top, 0)
                                }
                            }
                            Spacer()
                            Image(systemName: "pencil").font(Font.system(size: 25))
                        }
                        .padding(20).padding(.bottom)
                        .frame(width: btnWidth)
                        .background(Color("Primary_color")).cornerRadius(15)
                        .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2) )
                    }
                    .sheet(isPresented: $isShowingPaymentsForm) {
                        CheckoutView(showingPaySheet: $showingPaySheet, isShowingPaymentsForm: $isShowingPaymentsForm).presentationDetents([.height(250)])
                    }
                }
                .foregroundColor(.white)
                .padding(.vertical)
                .onAppear {
                    addressDetails.getAddress()
                    addressDetails.getCardDetails()
                }
            }
        }
        }
}

