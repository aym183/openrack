//
//  CheckoutView.swift
//  openrack
//
//  Created by Ayman Ali on 19/04/2023.
//

import SwiftUI
import Stripe

struct CheckoutView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var paymentMethodParams: STPPaymentMethodParams?
    let paymentGateway = PaymentGateway()
    @State var message = ""
    
    private func pay() {
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        paymentIntentParams.savePaymentMethod = NSNumber(value: true)
        
        paymentGateway.submitPayment(intent: paymentIntentParams) {
            status, intent, error in
            
            switch status {
            case .failed:
                message = "Failed"
            case .canceled:
                message = "Cancelled"
            case .succeeded:
                message = "Your payment has been successfully completed!"
            }
        }
    }
    
    var body: some View {
        VStack {
            Section {
                TextField("Name", text: $name).padding().border(Color.black, width: 2).padding(.horizontal)
                TextField("Email", text: $email).padding().border(Color.black, width: 2).padding(.horizontal)
                STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams).padding()
            } header: {
                Text("Payment Information").opacity(0.7)
            }
            
            
            HStack {
                Spacer()
                Button(action: {
                    pay()
                    print(message)
                }) {
                    Text("Pay")
                        .frame(width: 300, height: 50)
                }
                .background(Color("Primary_color"))
                .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
