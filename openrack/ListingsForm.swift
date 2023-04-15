//
//  ListingsForm.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import SwiftUI

struct ListingsForm: View {
    @State var streamName = ""
    @State var streamDescription = ""
    @State private var selectedCategory: Dropdownmenus? = nil
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack {
                Text("Category").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                
                DropdownMenu(
                    selectedOption: self.$selectedCategory, options: Dropdownmenus.allOptions
                )
                
                Text("Subcategory").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                
                Text("Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                
                TextField("", text: $streamName)
                    .padding(.horizontal, 8)
                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                    .background(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Text("Description").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                
                TextField("", text: $streamDescription)
                    .padding(.horizontal, 8)
                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                    .background(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Text("Quantity").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
            }
        }
        .foregroundColor(.black)
        }
}

struct ListingsForm_Previews: PreviewProvider {
    static var previews: some View {
        ListingsForm()
    }
}
