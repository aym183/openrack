//
//  ContentView.swift
//  openrack
//
//  Created by Ayman Ali on 26/03/2023.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    // Addef test comment
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack{
                
                Text("Openrack")
                    .font(Font.system(size: 70))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("Primary_color"))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                Text("Buy, Sell, Discover ✨")
                    .opacity(0.7)
                    .font(Font.system(size: 20))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50.0)
                
                Text("A peer-to-peer marketplace to buy & sell fashion in MENA.")
                    .font(Font.system(size: 25))
                    .padding(.horizontal, 10.0)
                    .padding(.top, 50.0)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                
                
                
                SignInWithAppleButton(
                    
                    onRequest: { request in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    },
                    onCompletion: { result in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    }
                )
                .frame(height: 50)
                .cornerRadius(50)
                .padding(.top, 70)
                .padding(.horizontal)

                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    Image("Facebook_Logo")
                    Text("Sign in with Facebook")
                        .font(.title3)
                        
                }
                .frame(width: 360, height: 50)
                .background(Color("Facebook_color"))
                .foregroundColor(Color.white)
                .cornerRadius(50)
                .padding(.horizontal)
                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    HStack{
                        Image("Google_Logo")
                        Text("Sign in with Google")
                            .font(.title3)
                    }
                    
                }
                .frame(width: 360, height: 50)
                .background(Color("Google_color"))
                .foregroundColor(Color.white)
                .cornerRadius(50)
                .padding(.horizontal)
                
                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Sign in with Email")
                            .font(.title3)
                    }
                    
                }
                .frame(width: 360, height: 50)
                .background(Color("Primary_color"))
                .foregroundColor(Color.white)
                .cornerRadius(50)
                .padding(.horizontal)
                
                Divider()
                    .frame(width: 300, height: 3)
                    .background(.black)
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Login with Email")
                            .font(.title3)
                    }
                    
                }
                .frame(width: 360, height: 50)
                .background(.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(50)
                .padding(.horizontal)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
