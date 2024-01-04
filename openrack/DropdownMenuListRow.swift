//
//  DropdownMenuListRow.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//
import SwiftUI

struct DropdownMenuListRow: View {
    let option: Dropdownmenus
    let onSelectedAction: (_ option: Dropdownmenus) -> Void
    var body: some View {
        Button(action: { self.onSelectedAction(option) }) {
            Text(option.option).frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.black)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}
