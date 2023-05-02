//
//  colorSelector.swift
//  openrack
//
//  Created by Ayman Ali on 13/04/2023.
//

import Foundation
import SwiftUI

class ColorSelector : ObservableObject {
    func getShowStatusColor(status: String) -> Color {
        if status == "Created" {
            return Color("Primary_color")
        } else if status == "Live" {
            return Color.red
        } else {
            return Color.green
        }
    }
    
    func getOrderStatusColor(status: String) -> Color {
        if status == "Processing" {
            return Color("Primary_color")
        } else {
            return Color.green
        }
    }
}
