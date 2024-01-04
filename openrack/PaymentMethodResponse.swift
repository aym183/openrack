//
//  PaymentModelResponse.swift
//  openrack
//
//  Created by Ayman Ali on 21/04/2023.
//
import Foundation

struct PaymentMethodResponse: Decodable {
    let cardBrand: String
    let lastFour: String
}
