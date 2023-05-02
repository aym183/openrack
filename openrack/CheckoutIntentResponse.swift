//
//  CheckoutIntentResponse.swift
//  openrack
//
//  Created by Ayman Ali on 19/04/2023.
//
import Foundation

struct CheckoutIntentResponse: Decodable {
    let clientSecret: String
    let customerID: String
    let paymentIntentID: String
}
