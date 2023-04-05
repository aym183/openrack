//
//  CustomNavbarView.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//

import SwiftUI

struct CustomNavbarView: View {
    var body: some View {
            HStack {
                
                Button(action: {}) {
                    Image(systemName: "slider.horizontal.3").font(.system(size: 10)).padding(.leading, 15).padding(.trailing, -22)
                    Text("Follows").font(Font.system(size: 12)).fontWeight(.bold).padding(.horizontal)
                }
                
                Spacer()
                
                VStack {
                    Text("Openrack").font(Font.system(size: 30)).fontWeight(.semibold)
                        .foregroundColor(Color("Primary_color")).padding(.vertical)
                        .padding(.leading, 5)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Favorites").font(Font.system(size: 12)).fontWeight(.bold).padding(.horizontal)
                    Image(systemName: "heart.fill").padding(.leading, -22).font(.system(size: 10)).padding(.trailing, 5)
                }
                
            }
            .frame(width: UIScreen.main.bounds.width )
            .background(Color("Secondary_color").ignoresSafeArea(edges: .top))
            .foregroundColor(Color("Primary_color"))
            .overlay(
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.black)
                    .offset(y: 0)
                    .shadow(color: .black, radius: 6, x: 0, y: 0.5)
                    ,alignment: .bottom
            )
        

    }
}
