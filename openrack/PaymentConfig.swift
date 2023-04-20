//
//  PaymentConfig.swift
//  openrack
//
//  Created by Ayman Ali on 19/04/2023.
//

import Foundation

class PaymentConfig {
    
    var paymentIntentClientSecret: String?
    static var shared: PaymentConfig = PaymentConfig()
    
    private init() { }
}
