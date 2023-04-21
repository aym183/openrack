//
//  PaymentDetails.swift
//  openrack
//
//  Created by Ayman Ali on 18/04/2023.
//

import SwiftUI

struct PaymentDetails: View {
    @Binding var showingPaySheet: Bool
    @Binding var isShowingPaymentsForm: Bool
    @Binding var isShowingAddressForm: Bool
    @StateObject var addressDetails = ReadDB()
    @AppStorage("email") var userEmail: String = ""
    @AppStorage("full_name") var fullName: String = ""
    @AppStorage("stripe_customer_id") var stripeCustomerID: String = ""
    
    private func startCheckout(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://foul-checkered-lettuce.glitch.me/create-payment-intent")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = try? JSONEncoder().encode(["customer_id": stripeCustomerID, "name": fullName, "email": userEmail, "price": "5"])
        
//        Listing(image: "tshirt.fill", title: "Off-White Tee", quantity: "2", price: "450", type: "Buy Now")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else {
                completion(nil)
                return
            }
            let checkoutIntentResponse = try? JSONDecoder().decode(CheckoutIntentResponse.self, from: data)
            
            if stripeCustomerID == "" {
                UpdateDB().updateStripeCustomerID(customerID: checkoutIntentResponse!.customerID)
            }
            completion(checkoutIntentResponse?.clientSecret)
            
        }.resume()
    }
    
    var body: some View {
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
                        .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2) )
                    }
                    .sheet(isPresented: $isShowingAddressForm) {
                        AddressForm(showingPaySheet: $showingPaySheet, isShowingAddressForm: $isShowingAddressForm).presentationDetents([.height(750)])
                    }
                    
                    Button(action: {
                        startCheckout { clientSecret in
                            
//                            print("Response in \(response)")
                            PaymentConfig.shared.paymentIntentClientSecret = clientSecret
                            DispatchQueue.main.async {
                                isShowingPaymentsForm.toggle()
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "creditcard.fill").padding(.trailing, 10).padding(.leading, 5)
                            VStack(alignment: .leading) {
                                Text("Payment")
                                    .fontWeight(.bold).font(Font.system(size: 20)).padding(.top)
                                Text("Please input your payment info.")
                                    .fontWeight(.semibold).font(Font.system(size: 14)).padding(.top, 0)
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
                        CheckoutView()
                    }
                }
                .foregroundColor(.white)
                .padding(.vertical)
                .onAppear {
                    addressDetails.getAddress()
                }
            }
        }
}

