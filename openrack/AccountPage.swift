//
//  AccountPage.swift
//  openrack
//
//  Created by Ayman Ali on 23/04/2023.
//

import SwiftUI

struct AccountPage: View {
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Account").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20).foregroundColor(.black)
            }
        }
    }
}

struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
}
