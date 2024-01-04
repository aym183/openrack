//
//  PaymentDetailsError.swift
//  openrack
//
//  Created by Ayman Ali on 03/05/2023.
//

import SwiftUI

struct PaymentDetailsError: View {
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack {
                Text("Please fill in your payment and shipping details to proceed!").font(Font.system(size: 22)).fontWeight(.bold).multilineTextAlignment(.center)
            }
            .foregroundColor(.black)
            .padding([.horizontal,.vertical])
        }
    }
}

struct PaymentDetailsError_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDetailsError()
    }
}
