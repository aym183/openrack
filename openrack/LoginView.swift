//
//  LoginView.swift
//  openrack
//
//  Created by Ayman Ali on 29/03/2023.
//

//import SwiftUI
//
//struct LoginView: View {
//    var signupVM = AuthViewModel()
//    @State var emailText = ""
//    @State var passwordText = ""
//    @State private var isOn = false
//    @State private var isPresented = false
//    
//    var isBothTextFieldsEmpty: Bool {
//            return emailText.isEmpty && passwordText.isEmpty
//        }
//    
//    var body: some View {
//            ZStack {
//                Color("Secondary_color").ignoresSafeArea()
//                VStack (alignment: .leading){
//                    
//                    Text("Sign Up").font(Font.system(size: 30)).fontWeight(.heavy).multilineTextAlignment(.trailing).padding(.top, 50)
//                    
//                    Text("Email").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 20)
//                    
//                    TextField("", text: $emailText)
//                        .padding(.horizontal, 8)
//                        .frame(width: 360, height: 50).border(Color.black, width: 2)
//                        .background(.white)
//                        .disableAutocorrection(true)
//                        .autocapitalization(.none)
//                    
//                    Text("Password").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10)
//                    
//                    SecureField("", text: $passwordText)
//                        .padding(.horizontal, 8)
//                        .frame(width: 360, height: 50).border(Color.black, width: 2)
//                        .background(.white)
//                        .disableAutocorrection(true)
//                        .autocapitalization(.none)
//                    
//                    HStack (spacing: 20) {
//                        Toggle(isOn: $isOn) {}.frame(width: 50, height: 50)
//                        Text("Remember Me")
//                            .font(Font.system(size: 16))
//                            .fontWeight(.semibold)
//                    }
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        isPresented.toggle()
//                        signupVM.signUpWithEmail(email: emailText, password: passwordText)
//                    }) {
//                        HStack {
//                            Text("Next").font(.title3)
//                        }
//                    }
//                    .disabled(isBothTextFieldsEmpty)
//                    .frame(width: 360, height: 50)
//                    .background(isBothTextFieldsEmpty ? Color.gray : Color("Primary_color"))
//                    .foregroundColor(.white)
//                    .border(Color.black, width: 2)
//                    .padding(.bottom)
//                    .sheet(isPresented: $isPresented, content: {
//                        UserUsername().transition(.move(edge: .leading))
//                    })
//                    
//                }
//                .padding(.horizontal)
//                .foregroundColor(.black)
//                
//            }
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
