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
        }

//        .titleTextAttributes([.foregroundColor: UIColor.blue, .font: UIFont.systemFont(ofSize: 24, weight: .bold)])
        }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
