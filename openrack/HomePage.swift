//
//  HomePage.swift
//  openrack
//
//  Created by Ayman Ali on 29/03/2023.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            VStack{
//                NavigationLink(destination: LandingPage()) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
                Text("HI THERE")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
