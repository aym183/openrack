//
//  BottomNavbar.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//
import SwiftUI
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
                    FeedPage(isShownFeed: false, isShownFirstFeed: false)
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
    }
}
