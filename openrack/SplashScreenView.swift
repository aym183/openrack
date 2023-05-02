//
//  SplashScreenView.swift
//  openrack
//
//  Created by Ayman Ali on 26/03/2023.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.5
    @Binding var showStart: Bool
    
    var body: some View {
        if showStart {
            ZStack {
                Color("Primary_color").ignoresSafeArea()
                Image("Logo").padding(.horizontal).opacity(opacity)
            }
            .onAppear {
                withAnimation(Animation.easeIn(duration: 2)) { self.opacity = 1.0 }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                    withAnimation{ self.showStart = false }
//                }
            }
        }
        
    }
}
