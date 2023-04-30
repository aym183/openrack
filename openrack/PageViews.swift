//
//  PageViews.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//

import SwiftUI

struct PageView: View {
    var body: some View {
        ZStack {
            Color("Primary_color").ignoresSafeArea()
            VStack {
                Text("Openrack").font(Font.system(size: 70)).fontWeight(.heavy)
                
                Text("A peer-to-peer marketplace to buy & sell fashion in MENA.").font(Font.system(size: 25)).fontWeight(.semibold)
                    .padding(.horizontal, 10.0)
                    .padding(.top).padding(.bottom, 30)
                    .multilineTextAlignment(.center)
                
                HStack (spacing: 40) {
                    VStack{
                        Image("AppStore_Logo")
                        Text("⭐️ 4.7")
                            .font(Font.system(size: 20)).fontWeight(.bold)
                            .padding(.top,2)
                    }
                    
                    VStack{
                        Image("ProductHunt_Logo")
                        Text("⬆️ 500").font(Font.system(size: 20)).fontWeight(.bold)
                            .padding(.top,5)
                    }
                    
                    VStack{
                        Image("PlayStore_Logo")
                        Text("⭐️ 4.3").font(Font.system(size: 20)).fontWeight(.bold)
                            .padding(.top,5)
                    }
                }
            }
            .multilineTextAlignment(.center)
            .foregroundColor(Color("Secondary_color"))
        }
        
    }
}


struct PageView2: View {
    var body: some View {
        ZStack {
            Color("Primary_color").ignoresSafeArea()
            VStack{
                Text("Why Us?")
                    .font(Font.system(size: 60)).fontWeight(.heavy)
                    .frame(width: 400)
                
                
                Text("✅ Online Payments\n✅ Fast Deliveries\n✅ Order Management\n✅ Buyback Protection\n✅ Built for All Sellers")
                    .font(Font.system(size: 30)).fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .padding(.top)
                
            }
            .foregroundColor(Color("Secondary_color"))
        }
    }
}

struct PageView3: View {
    @Binding var shouldShowOnboarding: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color("Primary_color").ignoresSafeArea()
                VStack{
                    Text("Let's Get Going!")
                        .font(Font.system(size: 60)).fontWeight(.heavy)
                        .frame(width: 400)
                    
                    Button(action: { shouldShowOnboarding.toggle() }) { Text("Ready").font(.title3) }
                        .frame(width: 100, height: 50)
                        .background(.white).foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                        )
                        .cornerRadius(50)
                        .padding(.horizontal)
                    
                }
                .multilineTextAlignment(.center)
                .foregroundColor(Color("Secondary_color"))
                .frame(height: 1300)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}
