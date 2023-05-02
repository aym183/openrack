//
//  ImageSelector.swift
//  openrack
//
//  Created by Ayman Ali on 16/04/2023.
//
import Foundation
class ImageSelector : ObservableObject {
    func getImage(category: String) -> String {
        if category == "Trading Cards" { return "menucard.fill" }
        else if category == "Sports" { return "sportscourt" }
        else if category == "Toys" { return "gamecontroller" }
        else if category == "Comics & Manga" { return "book.fill" }
        else if category == "Sneakers & Streetwear" { return "tshirt.fill" }
        else if category == "Vintage & Thrift Clothing" { return "tshirt.fill" }
        else if category == "Bags, Jewelry & Accessories" { return "bag.fill" }
        else if category == "Watches" { return "applewatch" }
        
        return ""
    }
}
