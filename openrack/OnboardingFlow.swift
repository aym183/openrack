//
//  OnboardingFlow.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//
import SwiftUI

struct OnboardingFlow : View {
    @Binding var shouldShowOnboarding: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color("Primary_color").ignoresSafeArea()
                TabView {
                    PageView()
                    PageView2()
                    PageView3(shouldShowOnboarding: $shouldShowOnboarding)
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
