//
//  HomePage.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
            VStack{
                CustomNavbarView()
                Spacer()
                ScrollView {
                   Text("Content")
                }
                
            }
            .background(Color("Secondary_color"))
        }

        }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
