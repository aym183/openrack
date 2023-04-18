//
//  PaymentDetails.swift
//  openrack
//
//  Created by Ayman Ali on 18/04/2023.
//

import SwiftUI

struct PaymentDetails: View {
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack(spacing: 20) {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "shippingbox.fill").padding(.trailing, 10).padding(.leading, 5)
                        VStack(alignment: .leading) {
                            Text("Shipping")
                                .fontWeight(.bold).font(Font.system(size: 20)).padding(.top)
                            Text("Please set your information here.")
                                .fontWeight(.medium).font(Font.system(size: 14))
                        }
                        Spacer()
                        Image(systemName: "pencil").font(Font.system(size: 25))
                    }
                    .padding(10).padding(.bottom)
                    .frame(width: 370)
                    .background(Color("Primary_color")).cornerRadius(15)
                    .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2) )
                }
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "creditcard.fill").padding(.trailing, 10).padding(.leading, 5)
                        VStack(alignment: .leading) {
                            Text("Payment")
                                .fontWeight(.bold).font(Font.system(size: 20)).padding(.top)
                            Text("Please input your payment info.")
                                .fontWeight(.medium).font(Font.system(size: 14))
                        }
                        Spacer()
                        Image(systemName: "pencil").font(Font.system(size: 25))
                    }
                    .padding(10).padding(.bottom)
                    .frame(width: 370)
                    .background(Color("Primary_color")).cornerRadius(15)
                    .overlay( RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2) )
                }
            }
            .foregroundColor(.white)
            .padding(.vertical)

            
        }
    }
}

struct PaymentDetails_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDetails()
    }
}
