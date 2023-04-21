//
//  CheckoutView.swift
//  openrack
//
//  Created by Ayman Ali on 19/04/2023.
//

import SwiftUI
import Stripe

struct CheckoutView: View {
    @State private var isOn = false
    @State private var paymentMethodParams: STPPaymentMethodParams?
    let paymentGateway = PaymentGateway()
    @State var message = ""
    
    private func pay() {
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else {
            return
        }
        
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        print(paymentIntentParams.paymentMethodParams)
//        paymentIntentParams.savePaymentMethod = NSNumber(value: true)
        
        paymentGateway.submitPayment(intent: paymentIntentParams) {
            status, intent, error in
            
            switch status {
                case .failed:
                    message = "Failed"
                case .canceled:
                    message = "Cancelled"
                case .succeeded:
                    message = "Your payment has been successfully completed!"
                    // execute payment method getting, collapse view, save and use to get card details for display
                    
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack {
                Section {
                    STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams).padding()
                } header: {
                    Text("Set Payment Information").opacity(0.7)
                }
                
                
                HStack {
                    Spacer()
                    Button(action: {
                        pay()
                    }) {
                        Text("Pay")
                            .frame(width: 300, height: 50)
                    }
                    .background(Color("Primary_color"))
                    .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical,5)
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
