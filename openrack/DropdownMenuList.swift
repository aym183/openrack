//
//  DropdownMenuList.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//
import SwiftUI

struct DropdownMenuList: View {
    let options: [Dropdownmenus]
    let onSelectedAction: (_ option: Dropdownmenus) -> Void
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 2) {
                ForEach(options) { option in
                    DropdownMenuListRow(option: option, onSelectedAction: self.onSelectedAction)
                }
            }
        }
        .frame(height: CGFloat(self.options.count * 32) > 300
               ? 300
               : CGFloat(self.options.count * 30)
        )
        .padding(.vertical, 5)
        .overlay {
            Rectangle().stroke(.black, lineWidth: 2)
        }
        .background(.white)
    }
}
