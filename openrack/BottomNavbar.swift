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
    @State var isShownFeed: Bool = true

    var body: some View {
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                if isShownFeed {
                    VStack {
                        ProgressView()
                            .scaleEffect(2.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        
                        Text("Getting Openrack Ready! 🥳").font(Font.system(size: 20)).fontWeight(.semibold).multilineTextAlignment(.center).padding(.top, 30).padding(.horizontal).foregroundColor(.black)
                    }
                }
                
                TabView(selection: $selectedTab){
                    FeedPage(isShownFeed: false)
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
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            isShownFeed = false
                        }
                    }
                }
                .opacity(isShownFeed ? 0 : 1)
            }
            
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
