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
    @State var fullNameText = ""
    @State var passwordText = ""
    @State var usernameText = ""
    @State var phoneText = "+971"
    @State private var isOn = false
    @State private var isUserPresented = false
    @State private var isAdminPresented = false
    @State private var isLogin = false
    @State var isLoading = false
    @State var isNavigationBarHidden = false
    @AppStorage("email") var userEmail: String = ""
    
    var isBothTextFieldsEmpty: Bool {
            return emailText.isEmpty || passwordText.isEmpty
    }
    
    var isPhoneTextFieldEmpty: Bool {
        if phoneText.count == 13 {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                if isLoading {
                    VStack {
                        ProgressView()
                            .scaleEffect(2.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        
                        Text("Fun Fact: 2% of all Openrack profits go to charity!").fontWeight(.semibold).multilineTextAlignment(.center).padding(.top, 30).padding(.horizontal).foregroundColor(.black)
                    }
                }
                
                VStack (alignment: .leading){
                    
                    Text(String(describing: userDetails[0])).font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
                    if String(describing: userDetails[3]) != "Phone" {
                        Text("Email").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $emailText)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    
                    if String(describing: userDetails[3]) == "Phone" {
                        Text("Phone Number").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $phoneText)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .keyboardType(.numberPad)
                        
                        Button(action: {}) {
                            HStack {
                                Text(String(describing: userDetails[2])).font(.title3).frame(width: 360, height: 50)
                            }
                        }
                        .disabled(isPhoneTextFieldEmpty)
    //                    .frame(width: 360, height: 50)
                        .background(isPhoneTextFieldEmpty ? Color.gray : Color("Primary_color"))
                        .foregroundColor(.white)
                        .border(Color.black, width: 2)
                        .padding(.vertical)
                        
                    }
                    
                    if String(describing: userDetails[3]) == "Yes" {
                        Text("Username").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $usernameText)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Text("Full Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $fullNameText)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Text("Password").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        SecureField("", text: $passwordText)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }

//                    if String(describing: userDetails[3]) == "Phone" {
//                        Text("Username").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
//
//                        TextField("", text: $usernameText)
//                            .padding(.horizontal, 8)
//                            .frame(width: 360, height: 50).border(Color.black, width: 2)
//                            .background(.white)
//                            .disableAutocorrection(true)
//                            .autocapitalization(.none)
//
//                        Text("Full Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
//
//                        TextField("", text: $fullNameText)
//                            .padding(.horizontal, 8)
//                            .frame(width: 360, height: 50).border(Color.black, width: 2)
//                            .background(.white)
//                            .disableAutocorrection(true)
//                            .autocapitalization(.none)
//
//                        Text("Password").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
//
//                        SecureField("", text: $passwordText)
//                            .padding(.horizontal, 8)
//                            .frame(width: 360, height: 50).border(Color.black, width: 2)
//                            .background(.white)
//                            .disableAutocorrection(true)
//                            .autocapitalization(.none)
//                    }
                    
                    if String(describing: userDetails[3]) == "No" {
                        Text("Password").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        SecureField("", text: $passwordText)
                            .padding(.horizontal, 8)
                            .frame(width: 360, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    
                    if String(describing: userDetails[3]) != "Phone" {
                        HStack (spacing: 30) {
                            Toggle(isOn: $isOn) {}.frame(width: 50, height: 50)
                            Text(String(describing: userDetails[1]))
                                .font(Font.system(size: 14))
                                .fontWeight(.medium)
                        }
                    }
                    Spacer()
                    
                    if String(describing: userDetails[3]) != "Phone" {
                        Button(action: {
                            withAnimation(.easeIn) {
                                if String(describing: userDetails[3]) == "Yes" {
                                    
                                    signupVM.signUpWithEmail(email: emailText, password: passwordText, username: usernameText, fullName: fullNameText)
                                    
                                    
                                } else if String(describing: userDetails[3]) == "Phone" {
                                    
                                } else {
                                    
                                    signupVM.signIn(email: emailText, password: passwordText)
                                    isNavigationBarHidden.toggle()
                                    isLoading.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                        if emailText == "ayman.ali1302@gmail.com" {
                                            isAdminPresented.toggle()
                                        } else {
                                            isUserPresented.toggle()
                                        }
                                        
                                    }
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                    
                                    //                                isPresented.toggle()
                                }
                            }
                            
                        }) {
                            HStack {
                                Text(String(describing: userDetails[2])).font(.title3).frame(width: 360, height: 50)
                            }
                        }
                        .navigationDestination(isPresented: $isAdminPresented) {
                            withAnimation(.easeIn(duration: 2)) {
                                BottomNavbar()
                                    .navigationBarBackButtonHidden(true)
                                
                            }
                        }
                        .navigationDestination(isPresented: $isUserPresented) {
                            withAnimation(.easeIn(duration: 2)) {
                                FeedPage()
                                    .navigationBarBackButtonHidden(true)
                                
                            }
                        }
                        .disabled(isBothTextFieldsEmpty)
                        //                    .frame(width: 360, height: 50)
                        .background(isBothTextFieldsEmpty ? Color.gray : Color("Primary_color"))
                        .foregroundColor(.white)
                        .border(Color.black, width: 2)
                        .padding(.bottom)
                        
                    }
                    // add here
                    
//                    .withAnimation(Animation.easeIn(duration: 0.5))
                    
//                    .sheet(isPresented: $isPresented, content: {
//                        UserUsername().transition(.move(edge: .leading))
//                    })
                    
                    
                }
                .padding(.horizontal)
                .foregroundColor(.black)
                .opacity(isLoading ? 0 : 1)
            }
            .onAppear {
                print(userDetails)
            }
        }
        .navigationBarHidden(isNavigationBarHidden)

        
    }
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInEmailView(userDetails: ["Login", "Remember Me", "Submit", "No", FeedPage()])
    }
}
