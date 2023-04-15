//
//  ListingViewModel.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import Foundation

class ListingViewModel: ObservableObject {
    @Published var listings = [Listing]()
}
