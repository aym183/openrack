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
        .frame(height: 200)
        .padding(.vertical, 5)
        .overlay {
            Rectangle()
                .stroke(.black, lineWidth: 2)
        }
        .background(.white)
    }
}

//struct DropdownMenuList_Previews: PreviewProvider {
//    static var previews: some View {
//        DropdownMenuList(options: Dropdownmenus.allOptions, onSelectedAction: _ in)
//    }
//}
