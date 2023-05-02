//
//  PaymentGateway.swift
//  openrack
//
//  Created by Ayman Ali on 19/04/2023.
//
import Foundation
import Stripe
import UIKit

class PaymentGateway: UIViewController {
    func submitPayment(intent: STPPaymentIntentParams, completion: @escaping (STPPaymentHandlerActionStatus, STPPaymentIntent?, NSError?) -> Void) {
        let paymentHandler = STPPaymentHandler.shared()
        
        paymentHandler.confirmPayment(intent, with: self) { (status, intent, error) in
            completion(status, intent, error)
        }
    }
}

extension PaymentGateway: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
