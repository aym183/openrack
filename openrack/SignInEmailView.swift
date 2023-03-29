//
//  SignInView.swift
//  openrack
//
//  Created by Ayman Ali on 29/03/2023.
//

import SwiftUI

struct SignInEmailView: View {
    
    var userDetails:  Array<Any> 
    var signupVM = AuthViewModel()
    @State var emailText = ""
    @State var passwordText = ""
    @State private var isOn = false
    @State private var isPresented = false
    @State private var isLogin = false
    
    var isBothTextFieldsEmpty: Bool {
            return emailText.isEmpty && passwordText.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack (alignment: .leading){
                    
                    Text(String(describing: userDetails[0])).font(Font.system(size: 30)).fontWeight(.heavy).multilineTextAlignment(.trailing).padding(.top, 30)
                    
                    Text("Email").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 20)
                    
                    TextField("", text: $emailText)
                        .padding(.horizontal, 8)
                        .frame(width: 360, height: 50).border(Color.black, width: 2)
                        .background(.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    Text("Password").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10)
                    
                    SecureField("", text: $passwordText)
                        .padding(.horizontal, 8)
                        .frame(width: 360, height: 50).border(Color.black, width: 2)
                        .background(.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    HStack (spacing: 30) {
                        Toggle(isOn: $isOn) {}.frame(width: 50, height: 50)
                        Text(String(describing: userDetails[1]))
                            .font(Font.system(size: 14))
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    Button(action: {
                        if String(describing: userDetails[3]) == "Yes" {
                            isPresented.toggle()
                            signupVM.signUpWithEmail(email: emailText, password: passwordText)
                            print(userDetails)
                        } else {
                            // Add navigation here for successful login
                            signupVM.signIn(email: emailText, password: passwordText)
                            print(signupVM.isSignedIn())
                            isPresented.toggle()
                            
                        }
                        
                    }) {
                        HStack {
                            Text(String(describing: userDetails[2])).font(.title3)
                        }
                    }
                    .navigationDestination(isPresented: $isPresented) {
                        AnyView(_fromValue: userDetails[4])
                        
                    }
                    .disabled(isBothTextFieldsEmpty)
                    .frame(width: 360, height: 50)
                    .background(isBothTextFieldsEmpty ? Color.gray : Color("Primary_color"))
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .padding(.bottom)
//                    .sheet(isPresented: $isPresented, content: {
//                        UserUsername().transition(.move(edge: .leading))
//                    })
                    
                    
                }
                .padding(.horizontal)
                .foregroundColor(.black)
                
            }
        }
    }
}

struct UserUsername: View {
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
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Text("Next").font(.title3)
                    }
                }
                .disabled(usernameText.isEmpty)
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


//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignInEmailView()
//    }
//}
