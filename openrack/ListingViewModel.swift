//
//  ListingViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import Foundation

class ListingViewModel: ObservableObject {
    @Published var listings: [Listing] = [
        Listing(image: "bag.fill", title: "Balenciaga Kicks", quantity: 5),
        Listing(image: "tshirt.fill", title: "Addidas Shirt", quantity: 2),
        Listing(image: "applewatch", title: "Off-White", quantity: 1),
        Listing(image: "sportscourt", title: "Air Force Ones", quantity: 1),
        Listing(image: "tshirt.fill", title: "Jordan 1's", quantity: 3)
    ]
}
