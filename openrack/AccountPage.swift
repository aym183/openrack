//
//  AccountPage.swift
//  openrack
//
//  Created by Ayman Ali on 23/04/2023.
//

import SwiftUI

struct AccountPage: View {
    @State var showingPaySheet = false
    @State var isShowingPaymentsForm = false
    @State var isShowingAddressForm = false
    @StateObject var addressDetails = ReadDB()
    
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Text("Account").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20).foregroundColor(.black).padding(.horizontal,5)
                    Spacer()
                }
                .foregroundColor(.black)
                
                Text("Personal Details").font(Font.system(size: 18)).fontWeight(.bold).foregroundColor(.black).opacity(0.7).padding(.horizontal,5)
                Divider().frame(width: 340, height: 2).background(.black).padding(.bottom, 5).opacity(0.5).padding(.horizontal,5)
                
                HStack {
                    Text("Username")
                    Text("aym1302").padding(.leading, 22)
                }
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding()
                
                HStack {
                    Text("Name")
                    Text("Ayman Ali").padding(.leading, 56)
                }
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding()
                
                HStack {
                    Text("Email")
                    Text("ayman.ali1302@gmail.com").font(Font.system(size: 15)).padding(.leading, 60)
                }
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding()
                
                HStack {
                    Text("Phone")
                    Text("+447859234405").padding(.leading, 53)
                }
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding()
                
//                Spacer()
                
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
                                Text("\(addressDetails.address!["full_name"]!)\n\(addressDetails.address!["address"]!)\n\(addressDetails.address!["city"]!) \(addressDetails.address!["postal_code"]!)")
                                    .fontWeight(.semibold).font(Font.system(size: 12)).multilineTextAlignment(.leading).padding(.top, 0)
                            }
                        }
                        Spacer()
                        Image(systemName: "pencil").font(Font.system(size: 25))
                    }
                    .padding(20).padding(.bottom)
                    .frame(width: 370)
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
                    .frame(width: 370)
                    .background(Color("Primary_color")).cornerRadius(15)
                    .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2) )
                }
                .sheet(isPresented: $isShowingPaymentsForm) {
                    //                            AddressForm()
                    //                        ExampleSwiftUIPaymentSheet()
                    CheckoutView(showingPaySheet: $showingPaySheet, isShowingPaymentsForm: $isShowingPaymentsForm).presentationDetents([.height(250)])
                }
                .padding(.top,5).padding(.bottom, 30)
            
                Spacer()
                
                
            }
            .frame(width: 350)
            .foregroundColor(.white)
            .onAppear {
                addressDetails.getAddress()
                addressDetails.getCardDetails()
            }
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
