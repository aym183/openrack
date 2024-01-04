//
//  PhoneVerification.swift
//  openrack
//
//  Created by Ayman Ali on 27/04/2023.
//
import SwiftUI
import Firebase

struct PhoneVerification: View {
    @State var verificationText = ""
    @Binding var phoneText: String
    @State private var isUserDetails = false
    @State var user_credentials: PhoneAuthCredential?
    @Binding var phoneID: String
    var isVerifyTextFieldEmpty: Bool {
        if verificationText.count == 6 {
            return false
        } else {
            return true
        }
    }
    var body: some View {
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 40
            var progressWidth = geometry.size.width - 250
            var varHeight = geometry.size.height - 20
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Verify Phone").font(Font.system(size: 30)).fontWeight(.bold)
                        Spacer()
                        ZStack(alignment: .leading) {
                            Capsule().frame(width: progressWidth, height: 12.5).foregroundColor(.gray)
                            Capsule().frame(width: (progressWidth)*(30/100), height: 12.5).foregroundColor(Color("Primary_color"))
                        }
                    }
                    .padding(.top, 40).padding(.trailing)
                    
                    Text("Phone Number").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    TextField("", text: $phoneText)
                        .padding(.horizontal, 8)
                        .frame(width: varWidth, height: 50).border(Color.black, width: 2)
                        .background(.white)
                        .disabled(true).padding(.leading, 0)
                    
                    Text("Verification Code").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    TextField("", text: $verificationText)
                        .padding(.horizontal, 8)
                        .frame(width: varWidth, height: 50).border(Color.black, width: 2)
                        .background(.white)
                        .keyboardType(.numberPad).padding(.leading, 0)
                    
                    Button(action: {
                        PhoneAuthProvider.provider().verifyPhoneNumber(phoneText, uiDelegate: nil) { (ID, err) in
                            if let error = err {
                                print("PHONE ERROR \(error.localizedDescription)")
                            } else {
                                if let phoneID = ID {
                                    self.phoneID = phoneID
                                }
                            }
                        }
                    }) {
                        Text("Resend Code").font(Font.system(size: 12)).fontWeight(.semibold).padding(.top, 0).foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        user_credentials = PhoneAuthProvider.provider().credential(withVerificationID: phoneID, verificationCode: verificationText)
                        isUserDetails.toggle()
                        
                    }) {
                        HStack {
                            Text("Verify").font(.title3).frame(width: varWidth, height: 50)
                        }
                    }
                    .disabled(isVerifyTextFieldEmpty)
                    .background(isVerifyTextFieldEmpty ? Color.gray : Color("Primary_color"))
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .padding(.vertical)
                    .navigationDestination(isPresented: $isUserDetails) {
                        if user_credentials != nil {
                            UserDetails(phoneText: $phoneText, user_credentials: $user_credentials).navigationBarHidden(true)
                        }
                    }
                }
                .frame(height: varHeight)
                .padding(.horizontal)
            }
            .foregroundColor(.black)
            
        }
    }
}
