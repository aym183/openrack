//
//  ListingsForm.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import SwiftUI

struct ListingsForm: View {
    @Binding var showingBottomSheet: Bool
    @State var listingName = ""
    @State var listingDescription = ""
    @State var listingQuantity = ""
    @State private var selectedCategory: Dropdownmenus? = nil
    @State private var selectedSubCategory: Dropdownmenus? = nil
    var areTextFieldsEmpty: Bool {
        return listingName.isEmpty || listingDescription.isEmpty || listingQuantity.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Add Listing").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
                    Text("Category").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    DropdownMenu( selectedOption: self.$selectedCategory, options: Dropdownmenus.categoryAllOptions )
                    
                    Text("Subcategory").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    DropdownMenu( selectedOption: self.$selectedSubCategory, options: Dropdownmenus.subCategoryAllOptions )
                    
                    Text("Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    TextField("", text: $listingName)
                        .padding(.horizontal, 8)
                        .frame(width: 360, height: 50).border(Color.black, width: 2)
                        .background(.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    VStack(alignment: .leading) {
                        Text("Description").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $listingDescription)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Text("Quantity").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $listingQuantity)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Spacer()
                        
                    }
                    
                    Button(action: {
                        print("\(listingName), \(listingDescription), \(listingQuantity), \(String(describing: selectedCategory!.option)), \(String(describing: selectedSubCategory!.option))")
                        showingBottomSheet.toggle()
                    }, label: { Text("Confirm").font(.title3) })
                    .disabled(areTextFieldsEmpty)
                    .frame(width: 360, height: 50)
                    .background(areTextFieldsEmpty ? Color.gray : Color("Primary_color"))
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .padding(.vertical)
                }
            }
            .foregroundColor(.black)
        }
        }
}

//struct ListingsForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ListingsForm(showingBottomSheet: true)
//    }
//}
