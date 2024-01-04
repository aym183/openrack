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
    static let categoryAllOptions: [Dropdownmenus] = [
        Dropdownmenus(option: "Trading Cards"),
        Dropdownmenus(option: "Sports"),
        Dropdownmenus(option: "Toys"),
        Dropdownmenus(option: "Comics & Manga"),
        Dropdownmenus(option: "Sneakers & Streetwear"),
        Dropdownmenus(option: "Vintage & Thrift Clothing"),
        Dropdownmenus(option: "Bags, Jewelry & Accessories"),
        Dropdownmenus(option: "Watches")
    ]
    
    static let subCategoryAllOptions: [Dropdownmenus] = [
        Dropdownmenus(option: "Men's"),
        Dropdownmenus(option: "Woman's"),
        Dropdownmenus(option: "Unisex")
    ]
    
    static let typeAllOptions: [Dropdownmenus] = [
        Dropdownmenus(option: "Auction"),
        Dropdownmenus(option: "Buy Now"),
        Dropdownmenus(option: "Giveaway")
    ]
    
    static let countryAllOptions: [Dropdownmenus] = [
        Dropdownmenus(option: "Jordan"),
        Dropdownmenus(option: "Kuwait"),
        Dropdownmenus(option: "Lebanon"),
        Dropdownmenus(option: "Oman"),
        Dropdownmenus(option: "Qatar"),
        Dropdownmenus(option: "Saudi Arabia"),
        Dropdownmenus(option: "United Arab Emirates")
    ]
}
