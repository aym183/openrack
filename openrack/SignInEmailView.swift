//
//  SignInView.swift
//  openrack
//
//  Created by Ayman Ali on 29/03/2023.
//
import SwiftUI
import Firebase
struct SignInEmailView: View {
    
    var userDetails:  Array<Any>
    var signupVM = AuthViewModel()
    @State var emailText = ""
    @State var fullNameText = ""
    @State var passwordText = ""
    @State var usernameText = ""
    @State var verificationText = ""
    @State var phoneText = "+971"
    @State var phoneID = ""
    @State private var isVerification = false
    @State private var isOn = false
    @State private var isUserPresented = false
    @State private var isAdminPresented = false
    @State private var isLogin = false
    @State var isLoading = false
    @State var isNavigationBarHidden = false
    @AppStorage("email") var userEmail: String = ""
    
    var isBothTextFieldsEmpty: Bool {
        return passwordText.isEmpty
    }
    
    var isPhoneTextFieldEmpty: Bool {
        if phoneText.count == 13 {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 40
            var progressWidth = geometry.size.width - 250
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
                                .frame(width: geometry.size.width - 30, height: 50).border(Color.black, width: 2)
                                .background(.white)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            Text("Username").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                            TextField("", text: $usernameText)
                                .padding(.horizontal, 8)
                                .frame(width: 320, height: 50).border(Color.black, width: 2)
                                .background(.white)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                        
                        if String(describing: userDetails[3]) == "Phone" {
                            
                            Text("Phone Number").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                            TextField("", text: $phoneText)
                                .padding(.horizontal, 8)
                                .frame(width: varWidth, height: 50).border(Color.black, width: 2)
                                .background(.white)
                                .keyboardType(.numberPad)
                            
                            Spacer()
                            
                            if !isVerification {
                                Button(action: {
                                    PhoneAuthProvider.provider().verifyPhoneNumber(phoneText, uiDelegate: nil) { (ID, err) in
                                        if let error = err {
                                            print("PHONE ERROR \(error.localizedDescription)")
                                        } else {
                                            if let phoneID = ID {
                                                self.phoneID = phoneID
                                            }
                                            self.isVerification.toggle()
                                        }
                                        
                                    }
                                }) {
                                    HStack {
                                        Text(String(describing: userDetails[2])).font(.title3).frame(width: varWidth, height: 50)
                                    }
                                }
                                .disabled(isPhoneTextFieldEmpty)
                                .background(isPhoneTextFieldEmpty ? Color.gray : Color("Primary_color"))
                                .foregroundColor(.white)
                                .border(Color.black, width: 2)
                                .padding(.vertical)
                                .navigationDestination(isPresented: $isVerification) {
                                    PhoneVerification(phoneText: $phoneText, phoneID: $phoneID).navigationBarHidden(true)
                                }
                            }
                            
                        }
                        
                        if String(describing: userDetails[3]) == "Yes" {
                            
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
                    }
                    .padding(.horizontal)
                    .foregroundColor(.black)
                    .opacity(isLoading ? 0 : 1)
                }
            }
            .navigationBarHidden(isNavigationBarHidden)
            
        }
    }
}
