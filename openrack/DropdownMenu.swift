//
//  DropdownMenu.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//
import SwiftUI

struct DropdownMenu: View {
    @State private var isOptionsPresented = false
    @Binding var selectedOption: Dropdownmenus?
    var width: CGFloat
    let options: [Dropdownmenus]
    var body: some View {
            Button(action: { withAnimation {self.isOptionsPresented.toggle()} }) {
                HStack {
                    Text(selectedOption == nil ? "Select..." : selectedOption!.option)
                    Spacer()
                    Image(systemName: self.isOptionsPresented ? "chevron.up" : "chevron.down")
                }
                .padding(.horizontal)
            }
            .frame(width: width, height: 50)
            .background(.white)
            .border(Color.black, width: 2)
            .overlay(alignment: .top) {
                VStack {
                    if self.isOptionsPresented {
                        Spacer(minLength: 60)
                        DropdownMenuList(options: self.options) { option in
                            self.isOptionsPresented = false
                            self.selectedOption = option
                        }
                    }
                }
            }
            .padding(
                .bottom, self.isOptionsPresented
                ? CGFloat(self.options.count * 32) > 300
                ? 300
                : CGFloat(self.options.count * 32)
                : 0
            )
    }
}
