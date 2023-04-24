//
//  AddressForm.swift
//  openrack
//
//  Created by Ayman Ali on 18/04/2023.
//

import SwiftUI

struct AddressForm: View {
    @State var fullName = ""
    @State var houseNumber = ""
    @State var street = ""
    @State var city = ""
    @State private var selectedCountry: Dropdownmenus? = nil
    @Binding var showingPaySheet: Bool
    @Binding var isShowingAddressForm: Bool
    
    var areTextFieldsEmpty: Bool {
        return fullName.isEmpty || houseNumber.isEmpty || city.isEmpty || street.isEmpty
    }
    
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Add Address").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
                    Text("Full Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    TextField("", text: $fullName)
                        .padding(.horizontal, 8)
                        .frame(width: 360, height: 50).border(Color.black, width: 2)
                        .background(.white)
                    
                    Text("House Number").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    TextField("", text: $houseNumber)
                        .padding(.horizontal, 8)
                        .frame(width: 360, height: 50).border(Color.black, width: 2)
                        .background(.white)
                    
                    Text("Street").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    TextField("", text: $street)
                        .padding(.horizontal, 8)
                        .frame(width: 360, height: 50).border(Color.black, width: 2)
                        .background(.white)
                    
                    Text("City").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    TextField("", text: $city)
                        .padding(.horizontal, 8)
                        .frame(width: 360, height: 50).border(Color.black, width: 2)
                        .background(.white)
                    
                    VStack (alignment: .leading){
                        
                        Text("Country").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        DropdownMenu( selectedOption: self.$selectedCountry, options: Dropdownmenus.countryAllOptions )
                        
                        Button(action: {
                            UpdateDB().updateUserAddress(address: ["full_name": fullName, "house_number": houseNumber, "street": street, "city": city, "country": selectedCountry!.option])
                            showingPaySheet.toggle()
                            isShowingAddressForm.toggle()
//                            print("The Address is \(fullName), \(addressDetails), \(addressDetailsSecondary), \(city), \(state), \(postalCode), \(selectedCountry!.option)")
                        }) {
                            Text("Save Info").font(.title3)
                        }
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
}

//struct AddressForm_Previews: PreviewProvider {
//    static var previews: some View {
//        AddressForm()
//    }
//}
