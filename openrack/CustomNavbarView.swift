//
//  CustomNavbarView.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//
import SwiftUI

struct CustomNavbarView: View {
    var addStream = ReadDB()
    @State var showingAccountPage = false
    @AppStorage("username") var userName: String = ""
    var body: some View {
            HStack {
                VStack {
                    Text("Openrack").font(Font.system(size: 30)).fontWeight(.semibold)
                        .foregroundColor(Color("Primary_color")).padding(.vertical)
                }
                .padding(.leading, 15)
                Spacer()
                Button(action: { withAnimation { showingAccountPage.toggle() } }) {
                    Image(systemName: "person.circle").font(Font.system(size: 18)).fontWeight(.semibold).padding(.trailing, -5)
                    Text(userName).font(Font.system(size: 12)).fontWeight(.bold).padding(.trailing, 15).foregroundColor(Color("Primary_color"))
                }
                .navigationDestination(isPresented: $showingAccountPage) {
                    AccountPage().navigationBarBackButtonHidden(true)
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
