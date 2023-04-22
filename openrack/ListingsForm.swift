//
//  ListingsForm.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import SwiftUI

struct ListingsForm: View {
//    @StateObject var listings = ListingViewModel()
    @Binding var listings: [Listing]
    @Binding var showingBottomSheet: Bool
    var listingID: String
    @State var listingName = ""
    @State var listingDescription = ""
    @State var listingQuantity = ""
    @State var listingPrice = ""
    @State private var selectedType: Dropdownmenus? = Dropdownmenus(option: "Select...")
    @State private var selectedCategory: Dropdownmenus? = nil
    @State private var selectedSubCategory: Dropdownmenus? = nil
    var areTextFieldsEmpty: Bool {
        return listingName.isEmpty || listingDescription.isEmpty || listingQuantity.isEmpty
    }
    @State var listing: [String: String] = [:]
    
    var body: some View {
        
        // Add type: Auction. Buy Now
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Add Listing").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                        
                        Text("Category").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        DropdownMenu( selectedOption: self.$selectedCategory, options: Dropdownmenus.categoryAllOptions )
                        
                        Text("Subcategory").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        DropdownMenu( selectedOption: self.$selectedSubCategory, options: Dropdownmenus.subCategoryAllOptions )
                        
                        VStack (alignment: .leading){
                            Text("Type").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                            
                            DropdownMenu( selectedOption: self.$selectedType, options: Dropdownmenus.typeAllOptions )
                        }
                        
                        Text("Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $listingName, prompt: Text("White Air Jordans, EU 42"))
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                        
                        VStack(alignment: .leading) {
                            Text("Description").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                            
                            TextField("", text: $listingDescription, prompt: Text("Grab Exclusive Kicks!"))
                                .padding(.horizontal, 8)
                                .frame(width: 360, height: 50).border(Color.black, width: 2)
                                .background(.white)
                            
                            
                            Text("Quantity").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                            
                            TextField("", text: $listingQuantity, prompt: Text("5"))
                                .padding(.horizontal, 8)
                                .frame(width: 360, height: 50).border(Color.black, width: 2)
                                .background(.white)
                            
                            if(String(describing: selectedType!.option) == "Buy Now") {
                                Text("Price").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                                
                                TextField("", text: $listingPrice, prompt: Text("450"))
                                    .padding(.horizontal, 8)
                                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                                    .background(.white)
                                
                                Spacer()
                            }
                            Spacer()
                        }
                        
                        Button(action: {
                            listing = ["name": listingName, "description": listingDescription, "quantity": listingQuantity, "category": String(describing: selectedCategory!.option), "subcategory": String(describing: selectedSubCategory!.option), "type": selectedType!.option , "price": selectedType!.option == "Buy Now" ? listingPrice: "0" ]
                            
                            let newListing = Listing(image: ImageSelector().getImage(category: String(describing: selectedCategory!.option)), title: listingName, quantity: listingQuantity, price: selectedType!.option == "Buy Now" ? listingPrice: "0", type: selectedType!.option)
                            listings.append(newListing)
                            
                            showingBottomSheet.toggle()
                            
                            DispatchQueue.global(qos: .background).async {
                                if listings.count > 1 {
                                    UpdateDB().updateListings(listing: listing, docRef: listingID)
                                } else {
                                    CreateDB().addListings(listing: listing, docRef: listingID)
                                }
                            }
                            
                        }, label: { Text("Confirm").font(.title3).frame(width: 360, height: 50) })
                        .disabled(areTextFieldsEmpty)
                        .background(areTextFieldsEmpty ? Color.gray : Color("Primary_color"))
                        .foregroundColor(.white)
                        .border(Color.black, width: 2)
                        .padding(.vertical)
                    }
                }
            }
            .foregroundColor(.black)
            .onAppear {
                        UIScrollView.appearance().showsVerticalScrollIndicator = false
                    }
        }
        }
}

//struct ListingsForm_Previews: PreviewProvider {
//    static var previews: some View {
//        ListingsForm(showingBottomSheet: true)
//    }
//}
