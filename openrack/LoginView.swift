//
//  ContentView.swift
//  openrack
//
//  Created by Ayman Ali on 26/03/2023.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    var signupVM = AuthViewModel()
    @State var showingBottomSheet = false
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack{
                
                Text("Openrack")
                    .font(Font.system(size: 70)).fontWeight(.heavy)
                    .foregroundColor(Color("Primary_color"))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                Text("Buy, Sell, Discover ✨")
                    .opacity(0.7)
                    .font(Font.system(size: 20)).font(.subheadline).fontWeight(.semibold)
                    .padding(.horizontal, 50.0)
                    .multilineTextAlignment(.center)
                
                Text("A peer-to-peer marketplace to buy & sell fashion in MENA.")
                    .font(Font.system(size: 25)).fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10.0).padding(.top, 50.0)
                    
                
                SignInWithAppleButton(
                    onRequest: { request in },
                    onCompletion: { result in }
                )
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(50)
                .padding(.top, 70).padding(.horizontal)

                
                Button(action: {}) {
                    Image("Facebook_Logo")
                    Text("Sign in with Facebook").font(.title3)
                }
                .frame(width: 360, height: 50)
                .background(Color("Facebook_color")).foregroundColor(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(50)
                .padding(.horizontal)
                
                Button(action: { DispatchQueue.global().async { signupVM.signInWithGoogle() } })
                {
                    HStack{
                        Image("Google_Logo")
                        Text("Sign in with Google").font(.title3)
                    }
                    
                }
                .frame(width: 360, height: 50)
                .background(Color("Google_color")).foregroundColor(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(50)
                .padding(.horizontal)
                
                Button(action: { showingBottomSheet.toggle() }) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Sign in with Email").font(.title3)
                    }
                }
                .frame(width: 360, height: 50)
                .background(Color("Primary_color")).foregroundColor(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(50)
                .padding(.horizontal)
                .sheet(isPresented: $showingBottomSheet) {
                    BottomSheetView()
                }
                
                Divider().frame(width: 300, height: 3).background(.black).padding(.top, 5).padding(.bottom, 5)
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "envelope.fill")
                        Text("Login with Email").font(.title3)
                    }
                }
                .frame(width: 360, height: 50)
                .background(.white).foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(50)
                .padding(.horizontal)
                
                Text("By continuing you agree to our Terms of Service.\nOpenrack services are subject to our Privacy Policy.")
                    .font(.footnote).fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal).padding(.top, 20)
                    .opacity(0.7)

            }
        }
    }
    }


struct BottomSheetView: View {
    @State var emailText = ""
    @State var passwordText = ""
    @State private var isOn = false
    @State private var isPresented = false
    
    var isBothTextFieldsEmpty: Bool {
            return emailText.isEmpty && passwordText.isEmpty
        }
    
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack (alignment: .leading){
                
                Text("Sign Up").font(Font.system(size: 30)).fontWeight(.heavy).multilineTextAlignment(.trailing).padding(.top, 50)
                
                
                Text("Email").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 20)
                
                
                TextField("", text: $emailText)
                    .padding(.top, -5).padding(.horizontal, 8)
                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                    .background(.white)
                
                Text("Password").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10)
                
                SecureField("", text: $passwordText)
                    .padding(.top, -5).padding(.horizontal, 8)
                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                    .background(.white)
                    
                
                HStack (spacing: 30) {
                    Toggle(isOn: $isOn) {}.frame(width: 50, height: 50)
                    Text("Sign up for email to access sales, exclusive drops & more from Openrack")
                        .font(Font.system(size: 14))
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                Button(action: {
                    print(emailText)
                    print(passwordText)
                    isPresented.toggle()
                }) {
                    HStack {
                        Text("Next").font(.title3)
                    }
                }
                .frame(width: 360, height: 50)
                .background(isBothTextFieldsEmpty ? Color.gray : Color("Primary_color"))
                .foregroundColor(.white)
                .border(Color.black, width: 2)
                .padding(.bottom)
                .sheet(isPresented: $isPresented, content: {
                    AnotherBottomSheetView()
                })
                
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            
        }
    }
}


struct AnotherBottomSheetView: View {
    @State var usernameText = ""
    
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack (alignment: .leading){
                
                Text("Create a Username").font(Font.system(size: 30)).fontWeight(.heavy).multilineTextAlignment(.trailing).padding(.top, 50)
                
                Text("Username").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 20)
                
                TextField("", text: $usernameText)
                    .padding(.top, -5).padding(.horizontal, 8)
                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                    .background(.white)
                
     
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Text("Next").font(.title3)
                    }
                }
                .frame(width: 360, height: 50)
                .background(usernameText.isEmpty ? Color.gray : Color("Primary_color"))
                .foregroundColor(.white)
                .border(Color.black, width: 2)
                .padding(.bottom)
                
            }
            .padding(.horizontal)
            .foregroundColor(.black)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

