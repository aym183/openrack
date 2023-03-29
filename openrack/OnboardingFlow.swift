//
//  HomePage.swift
//  openrack
//
//  Created by Ayman Ali on 29/03/2023.
//

import SwiftUI

struct OnboardingFlow: View {
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: LandingPage().navigationBarBackButtonHidden(true)){
                    Text("Content")
                }
                Text("HI THERE")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlow()
    }
}
