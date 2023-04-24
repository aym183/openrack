//
//  AccountPage.swift
//  openrack
//
//  Created by Ayman Ali on 23/04/2023.
//

import SwiftUI

struct AccountPage: View {
    @AppStorage("email") var userEmail: String = ""
    @AppStorage("username") var userName: String = ""
    @AppStorage("full_name") var fullName: String = ""
    @State var showingPaySheet = false
    @State var disableFields = true
    @State var showingFeedPage = false
    @State var usernameText = ""
    @State var nameText = ""
    @State var emailText = ""
    @State var phoneText = ""
    @State var isShowingPaymentsForm = false
    @State var isShowingAddressForm = false
    @StateObject var addressDetails = ReadDB()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: { showingFeedPage.toggle() }) {
                            Image(systemName: "arrow.backward").font(Font.system(size: 25)).fontWeight(.bold).foregroundColor(.black)
                            Text("Account").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20).foregroundColor(.black).padding(.horizontal,5)
                        }
                        Spacer()
                    }
                    .foregroundColor(.black)
                    
                    HStack {
                        Text("Personal Details").font(Font.system(size: 18)).fontWeight(.bold).foregroundColor(.black).padding(.horizontal,5)
                        
                        Spacer()
                        
                        Button(action: { disableFields.toggle() }) {
                            Image(systemName: "applepencil").font(Font.system(size: 20)).fontWeight(.bold).foregroundColor(.black)
                        }
                        .padding(.trailing)
                    }
                    .opacity(0.7)
                    
                    Divider().frame(width: 340, height: 2).background(.black).padding(.bottom, 5).opacity(0.5).padding(.horizontal,5)
                    
                    HStack {
                        Text("Username").padding(.trailing, 20)
                        TextField("", text: $usernameText)
                            .padding(.horizontal, 8)
                            .opacity(disableFields ? 0.7 : 1)
                            .frame(width: 200, height: 35).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .disabled(disableFields)
                            
                        
//                        Text(userName).padding(.leading, 22)
                    }
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding()
                    
                    HStack {
                        Text("Name").padding(.trailing, 55)
                        TextField("", text: $nameText)
                            .padding(.horizontal, 8)
                            .opacity(disableFields ? 0.7 : 1)
                            .frame(width: 200, height: 35).border(Color.black, width: 2)
                            .background(.white)
                            .disabled(disableFields)
//                        Text(fullName).padding(.leading, 56)
                    }
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding()
                    
                    HStack {
                        Text("Email").padding(.trailing, 58)
                        TextField("", text: $emailText)
                            .padding(.horizontal, 8)
                            .opacity(disableFields ? 0.7 : 1)
                            .frame(width: 200, height: 35).border(Color.black, width: 2)
                            .background(.white)
                            .disabled(disableFields)
//                        Text(userEmail).font(Font.system(size: 15)).padding(.leading, 60)
                    }
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding()
                    
                    HStack {
                        Text("Phone").padding(.trailing, 51)
                        TextField("", text: $phoneText)
                            .padding(.horizontal, 8)
                            .opacity(disableFields ? 0.7 : 1)
                            .frame(width: 200, height: 35).border(Color.black, width: 2)
                            .background(.white)
                            .disabled(disableFields)
//                        Text("+447859234405").padding(.leading, 53)
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
                                    Text("\(addressDetails.address!["full_name"]!)\n\(addressDetails.address!["house_number"]!)\n\(addressDetails.address!["street"]!), \(addressDetails.address!["city"]!)")
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
            .navigationDestination(isPresented: $showingFeedPage) {
                if userEmail != "ayman.ali1302@gmail.com" {
                    FeedPage()
                        .navigationBarBackButtonHidden(true)
                } else {
                    BottomNavbar().navigationBarBackButtonHidden(true)
                }
            }
            .onAppear {
                usernameText = userName
                nameText = fullName
                emailText = userEmail
                phoneText = "+447859234405"
            }
            
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
