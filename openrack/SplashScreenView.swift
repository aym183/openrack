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
    
    var body: some View {
        if isActive {
            let viewModel = AuthViewModel()
            LandingPage(shouldShowOnboarding: true).environmentObject(viewModel)
        } else{
            ZStack {
                Color("Primary_color").font(.system(size: 20)).ignoresSafeArea()
                Image("Logo").padding(.horizontal).opacity(opacity)
            }
            .onAppear {
                withAnimation(Animation.easeIn(duration: 1.2)) { self.opacity = 1.0 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation{ self.isActive = true }
                }
            }
        }
    }
}
