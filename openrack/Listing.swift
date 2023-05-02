//
//  Listing.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//
import Foundation

struct Listing: Identifiable, Codable {
    var id = UUID()
    let image: String
    let title: String
    let quantity: String
    let price: String
    let type: String
}
