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
    @AppStorage("email") var userEmail: String = ""

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab){
                FeedPage()
                    .tabItem {
                        Image(systemName: "rectangle.3.offgrid")
                        Text("My Feed")
                    }
                
                
                ShowsPage()
                    .tabItem {
                        Image(systemName: "video.fill")
                        Text("My Shows")
                    }
            }
            .accentColor(Color("Primary_color"))
        }
//        .overlay(
//            Rectangle()
//                .frame(height: 0.5)
//                .foregroundColor(.black)
//                .offset(y: -55)
//                .shadow(color: .black, radius: 6, x: 0, y: 0.5)
//                ,alignment: .bottom
//        )
    }

}

struct BottomNavbar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavbar()
    }
}
