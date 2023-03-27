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
            Color("Secondary").ignoresSafeArea()
            VStack{
                
                Text("Openrack")
                    .font(Font.system(size: 70))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("Primary"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 100.0)
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
                .padding(.horizontal)

                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    Text("Sign in with Facebook")
                    
                }
                .frame(width: 360, height: 50)
                .background(Color("Facebook"))
                .foregroundColor(Color.white)
                .cornerRadius(50)
                .padding(.horizontal)
                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    Text("Sign in with Google")
                }
                .frame(width: 360, height: 50)
                .background(Color("Google"))
                .foregroundColor(Color.white)
                .cornerRadius(50)
                .padding(.horizontal)
                
                Button(action: {
                    // Action to perform when the button is tapped
                }) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Sign in with Email")
                    }
                    
                }
                .frame(width: 360, height: 50)
                .background(Color("Primary"))
                .foregroundColor(Color.white)
                .cornerRadius(50)
                .padding(.horizontal)
                
                
                
                     
                Spacer()
                    .padding([.top, .leading, .trailing])
//                Text("Hi")
            }
            
//                Spacer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
