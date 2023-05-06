//
//  AccountPage.swift
//  openrack
//
//  Created by Ayman Ali on 23/04/2023.
//
import SwiftUI

struct AccountPage: View {
    @AppStorage("username") var userName: String = ""
    @AppStorage("full_name") var fullName: String = ""
    @AppStorage("phone_number") var phoneNumber: String = ""
    @State var showingPaySheet = false
    @State var disableFields = true
    @State var showingFeedPage = false
    @State var usernameText = ""
    @State var nameText = ""
    @State var emailText = ""
    @State var phoneText = ""
    @State var isShowingPaymentsForm = false
    @State var isShowingAddressForm = false
    @State var isShowingOrders = false
    @StateObject var readListing = ReadDB()
    
    var body: some View {
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 220
            var btnWidth = geometry.size.width - 40
            NavigationStack {
                ZStack {
                    Color("Secondary_color").ignoresSafeArea()
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: { withAnimation { showingFeedPage.toggle() } }) {
                                Image(systemName: "arrow.backward").font(Font.system(size: 25)).fontWeight(.bold).foregroundColor(.black)
                                Text("Account").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20).foregroundColor(.black).padding(.horizontal,5)
                            }
                            Spacer()
                        }
                        .foregroundColor(.black)
                        
                        HStack {
                            Text("Personal Details").font(Font.system(size: 18)).fontWeight(.bold).foregroundColor(.black).padding(.horizontal,5).opacity(0.7)
                            
                            Spacer()
                            
                            //                        Button(action: {
                            //                            if disableFields == false {
                            //                                // Add phone number update
                            //                                UpdateDB().updateUserDetails(inputs: ["full_name": nameText])
                            //                                disableFields.toggle()
                            //                            } else {
                            //                                disableFields.toggle()
                            //                            }
                            //
                            //                        }) {
                            //                            if disableFields == false {
                            //                                Text(String("Save Details")).font(Font.system(size: 15)).frame(width: 100, height: 30).background(Color("Primary_color"))
                            //                                    .foregroundColor(.white)
                            //                                    .border(Color.black, width: 2)
                            //                            } else {
                            //                                Image(systemName: "applepencil").font(Font.system(size: 20)).fontWeight(.bold).foregroundColor(.black).opacity(0.7)
                            //                            }
                            //                        }
                                .padding(.trailing)
                        }
                        
                        
                        Divider().frame(width: 340, height: 2).background(.black).padding(.bottom, 5).opacity(0.5).padding(.horizontal,5)
                        
                        HStack {
                            Text("Username").font(Font.system(size: 15)).padding(.trailing, 25)
                            TextField("", text: $usernameText)
                                .font(Font.system(size: 13))
                                .padding(.horizontal, 8)
                                .frame(width: varWidth, height: 30)
                                .background(.gray)
                                .opacity(0.5)
                                .border(Color.black, width: 2)
                                .disabled(true)
                            
                            
                            //                        Text(userName).padding(.leading, 22)
                        }
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .padding()
                        
                        HStack {
                            Text("Phone").font(Font.system(size: 15)).padding(.trailing, 54)
                            TextField("", text: $phoneText)
                                .font(Font.system(size: 13))
                                .padding(.horizontal, 8)
                                .frame(width: varWidth, height: 30)
                                .background(.gray)
                                .opacity(0.5)
                                .border(Color.black, width: 2)
                                .disabled(true)
                            //                        Text("+447859234405").padding(.leading, 53)
                        }
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .padding()
                        
                        
                        //                    HStack {
                        //                        Text("Email").padding(.trailing, 58)
                        //                        TextField("", text: $emailText)
                        //                            .font(Font.system(size: 13))
                        //                            .padding(.horizontal, 8)
                        //                            .frame(width: 200, height: 35)
                        //                            .background(.gray)
                        //                            .opacity(0.5)
                        //                            .border(Color.black, width: 2)
                        //                            .disabled(true)
                        ////                        Text(userEmail).font(Font.system(size: 15)).padding(.leading, 60)
                        //                    }
                        //                    .foregroundColor(.black)
                        //                    .fontWeight(.semibold)
                        //                    .padding()
                        
                        //                    HStack {
                        //                        Text("Name").padding(.trailing, 55)
                        //                        TextField("", text: $nameText)
                        //                            .font(Font.system(size: 13))
                        //                            .padding(.horizontal, 8)
                        //                            .frame(width: 200, height: 35)
                        //                            .background(disableFields ? .gray : .white)
                        //                            .opacity(disableFields ? 0.5 : 1)
                        //                            .border(Color.black, width: 2)
                        //                            .disabled(disableFields)
                        ////                        Text(fullName).padding(.leading, 56)
                        //                    }
                        //                    .foregroundColor(.black)
                        //                    .fontWeight(.semibold)
                        //                    .padding()
                        
                        
                        //                Spacer()
                        
                        
                        Button(action: { isShowingOrders.toggle() }) {
                            HStack {
                                Image(systemName: "tshirt.fill").padding(.trailing, 10).padding(.leading, 5)
                                VStack(alignment: .leading) {
                                    Text("Orders")
                                        .fontWeight(.bold).font(Font.system(size: 20)).padding(.top)
                                    Text("Have a look at your orders!")
                                        .fontWeight(.semibold).font(Font.system(size: 14)).padding(.top, 0)
                                }
                                Spacer()
                            }
                            .padding().padding(.bottom)
                            .frame(width: btnWidth)
                            .background(Color("Primary_color")).cornerRadius(15)
                            .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2) )
                        }
                        .padding(.top, 10).padding(.bottom, -10)
                        .sheet(isPresented: $isShowingOrders) {
                            OrdersPage(orders: readListing.userOrders!).presentationDetents([.height(500)])
                        }
                        .padding(.horizontal,5)
                        
                        Button(action: { isShowingAddressForm.toggle() }) {
                            HStack {
                                Image(systemName: "shippingbox.fill").padding(.trailing, 10).padding(.leading, 5)
                                VStack(alignment: .leading) {
                                    Text("Shipping")
                                        .fontWeight(.bold).font(Font.system(size: 20)).padding(.top)
                                    
                                    if readListing.address == nil {
                                        Text("Please set your information here.")
                                            .fontWeight(.semibold).font(Font.system(size: 14)).multilineTextAlignment(.leading).padding(.top, 0)
                                    } else {
                                        Text("\(readListing.address!["full_name"]!)\n\(readListing.address!["house_number"]!)\n\(readListing.address!["street"]!), \(readListing.address!["city"]!)")
                                            .fontWeight(.semibold).font(Font.system(size: 12)).multilineTextAlignment(.leading).padding(.top, 0)
                                    }
                                }
                                Spacer()
                                Image(systemName: "pencil").font(Font.system(size: 25))
                            }
                            .padding().padding(.bottom)
                            .frame(width: btnWidth)
                            .background(Color("Primary_color")).cornerRadius(15)
                            .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                        }
                        .sheet(isPresented: $isShowingAddressForm) {
                            AddressForm(showingPaySheet: $showingPaySheet, isShowingAddressForm: $isShowingAddressForm, readListing: readListing).presentationDetents([.height(750)])
                        }
                        .padding(.top).padding(.horizontal,5)
                        
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
                                    if readListing.cardDetails == nil {
                                        Text("Please input your payment info.")
                                            .fontWeight(.semibold).font(Font.system(size: 14)).padding(.top, 0)
                                    } else {
                                        Text("\(readListing.cardDetails!["card_brand"]!) - \(readListing.cardDetails!["last_four"]!)").fontWeight(.semibold).font(Font.system(size: 12)).multilineTextAlignment(.leading).padding(.top, 0)
                                    }
                                }
                                Spacer()
                                Image(systemName: "pencil").font(Font.system(size: 25))
                            }
                            .padding().padding(.bottom)
                            .frame(width: btnWidth)
                            .background(Color("Primary_color")).cornerRadius(15)
                            .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2) )
                        }
                        .sheet(isPresented: $isShowingPaymentsForm) {
                            //                            AddressForm()
                            //                        ExampleSwiftUIPaymentSheet()
                            CheckoutView(showingPaySheet: $showingPaySheet, isShowingPaymentsForm: $isShowingPaymentsForm, readListing: readListing).presentationDetents([.height(250)])
                        }
                        .padding(.top,5).padding(.bottom, 30).padding(.horizontal,5)
                        
                        
                        Spacer()
                        
                        
                    }
                    .frame(width: 350)
                    .foregroundColor(.white)
                    .onAppear {
                        readListing.getAddress()
                        readListing.getCardDetails()
                        readListing.getUserOrders()
                    }
                }
                .navigationDestination(isPresented: $showingFeedPage) {
                    if userName != "aali183" {
                        FeedPage(isShownFeed: false, isShownFirstFeed: false).navigationBarBackButtonHidden(true)
                    } else {
                        BottomNavbar(isShownFeed: false).navigationBarBackButtonHidden(true)
                    }
                }
                .onAppear {
                    usernameText = userName
                    nameText = fullName
                    phoneText = phoneNumber
                }
                
            }
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
