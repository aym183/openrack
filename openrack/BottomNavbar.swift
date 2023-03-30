//
//  BottomNavbar.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//

import SwiftUI

//magnifyingglass - Explore
//person.fill - Account
//rectangle.3.offgrid - My Feed
//dollarsign.square - Sell

struct BottomNavbar: View {
    
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab){
             HomePage()
                .tabItem {
                    Image(systemName: "rectangle.3.offgrid")
                    Text("Home")
                }
            
            Text("Hello, World2!")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            Text("Hello, World!3")
                .tabItem {
                    Image(systemName: "dollarsign.square")
                    Text("Sell")
                }
            
            Text("Hello, World!4")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
        .accentColor(Color("Primary_color"))
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.black)
                .offset(y: -55)
                .shadow(color: .black, radius: 6, x: 0, y: 0.5)
                ,alignment: .bottom
        )
    }
        
}

struct BottomNavbar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavbar()
    }
}
