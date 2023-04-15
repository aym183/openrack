//
//  DropdownMenus.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import Foundation

struct Dropdownmenus: Identifiable, Hashable {
    let id = UUID().uuidString
    let option: String
}

extension Dropdownmenus {
    static let singleOption: Dropdownmenus = Dropdownmenus(option: "Trading Cards")
    static let allOptions: [Dropdownmenus] = [
        Dropdownmenus(option: "Trading Cards"),
        Dropdownmenus(option: "Sports"),
        Dropdownmenus(option: "Toys"),
        Dropdownmenus(option: "Comics & Manga"),
        Dropdownmenus(option: "Sneakers & Streetwear"),
        Dropdownmenus(option: "Vintage & Thrift Clothing"),
        Dropdownmenus(option: "Bags, Jewelry & Accessories"),
        Dropdownmenus(option: "Watches"),
        Dropdownmenus(option: "Video Games & Movies")
    ]
}
