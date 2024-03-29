//
//  CheckoutView.swift
//  openrack
//
//  Created by Ayman Ali on 19/04/2023.
//
import SwiftUI
import Stripe
import SPAlert

struct CheckoutView: View {
    @State private var isOn = false
    @State private var paymentMethodParams: STPPaymentMethodParams?
    let paymentGateway = PaymentGateway()
    @Binding var showingPaySheet: Bool
    @Binding var isShowingPaymentsForm: Bool
    @State var title = ""
    @State var showFailureAlert = false
    @State var showSuccessAlert = false
    @ObservedObject var readListing: ReadDB
    
    private func pay() {
        guard let clientSecret = PaymentConfig.shared.paymentIntentClientSecret else { return }
        guard let paymentIntentID = PaymentConfig.shared.paymentIntentID else { return }
        let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams
        
        paymentGateway.submitPayment(intent: paymentIntentParams) {
            status, intent, error in
            
            switch status {
                case .failed:
                    title = "Failed"
                    showFailureAlert.toggle()
                case .canceled:
                    title = "Cancelled"
                case .succeeded:
                    title = "Success"
                    showSuccessAlert.toggle()
                    ReadServer().getPaymentMethod(payment_intent: paymentIntentID) { paymentMethod in
                        UpdateDB().updateStripePaymentMethodID(paymentMethodID: paymentMethod!)
                        ReadServer().getPaymentMethodDetails(payment_method: paymentMethod!) { response in
                            UpdateDB().updateStripePaymentDetails(paymentDetails: [response[0]!, response[1]!])
                            readListing.getCardDetails()
                        }
                    }
                    showingPaySheet.toggle()
                    isShowingPaymentsForm.toggle()
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("Primary_color").ignoresSafeArea()
            VStack {
                Text("Set Payment Information").font(Font.system(size: 20)).fontWeight(.semibold).foregroundColor(.white)
                STPPaymentCardTextField.Representable.init(paymentMethodParams: $paymentMethodParams).border(.black, width: 2).padding()
                HStack {
                    Spacer()
                    Button(action: { pay() }) {
                        Text("Pay")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(width: 250, height: 50)
                            .foregroundColor(.black)
                    }
                    .background(Color("Secondary_color"))
                    .border(.black, width: 2)
                    Spacer()
                }
                .padding(.vertical,5)
            }
            .foregroundColor(.black)
            .SPAlert(
                isPresent: $showFailureAlert,
                message: "Incorrect payment details 😔",
                duration: 2.0,
                haptic: .error
            )
            .SPAlert(
                isPresent: $showSuccessAlert,
                title: title,
                message: "Your payment details have been added!",
                duration: 2.0,
                dismissOnTap: false,
                preset: .done,
                haptic: .success,
                layout: .init()
            )
        }
    }
}
