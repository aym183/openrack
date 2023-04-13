//
//  colorSelector.swift
//  openrack
//
//  Created by Ayman Ali on 13/04/2023.
//


import Foundation
import SwiftUI

class ColorSelector : ObservableObject {
    func getStatusColor(status: String) -> Color {
        if status == "Created" {
            return Color("Primary_color")
        } else if status == "Live" {
            return Color.red
        } else {
            return Color.green
        }
    }
}
