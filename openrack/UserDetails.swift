//
//  UserDetails.swift
//  openrack
//
//  Created by Ayman Ali on 27/04/2023.
//
import SwiftUI
import Firebase

struct UserDetails: View {
    @Binding var phoneText: String
    @Binding var user_credentials: PhoneAuthCredential?
    @State private var isFullNameDetails = false
    @State var usernameText = ""
    var isUsernameEmpty: Bool {
        return usernameText.isEmpty
    }
    
    var body: some View {
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 40
            var varHeight = geometry.size.height - 20
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("User Details").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
                    Text("Username").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    TextField("", text: $usernameText)
                        .padding(.horizontal, 8)
                        .frame(width: varWidth, height: 50).border(Color.black, width: 2)
                        .background(.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    Spacer()
                    
                    Button(action: {
                        isFullNameDetails.toggle()
                        //                    AuthViewModel().phoneSignIn(phoneNumber: phoneText, username: usernameText, fullName: fullNameText, credential: credential)
                        
                    }) {
                        HStack {
                            Text("Next").font(.title3).frame(width: varWidth, height: 50)
                        }
                    }
                    .disabled(isUsernameEmpty)
                    //                    .frame(width: 360, height: 50)
                    .background(isUsernameEmpty ? Color.gray : Color("Primary_color"))
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .padding(.vertical)
                    .navigationDestination(isPresented: $isFullNameDetails) {
                        FullNameDetails(phoneText: $phoneText, user_credentials: $user_credentials, usernameText: $usernameText)
                        //                    if user_credentials != nil {
                        //                        UserDetails(phoneText: $phoneText, phoneID: $phoneID, user_credentials: $user_credentials)
                        //                    }
                    }
                    
                }
                .frame(height: varHeight)
            }
            .foregroundColor(.black)
            .onAppear {
                print("\(phoneText), \(user_credentials)")
            }
        }
    }
   
}

struct FullNameDetails: View {
    @State var fullNameText = ""
    @Binding var phoneText: String
    @Binding var user_credentials: PhoneAuthCredential?
//    @State private var isHomePage = false
    @State private var isAdminPage = false
    @State private var isUserPage = false
    @State private var isNavigationBarHidden = false
    @Binding var usernameText: String
    @State var isLoading  = false
    
    var isFullNameEmpty: Bool {
        return fullNameText.isEmpty
    }
    var body: some View {
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 40
            var varHeight = geometry.size.height - 20
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                
                VStack(alignment: .leading) {
                    Text("User Details").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
                    Text("Full Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                    
                    TextField("", text: $fullNameText)
                        .padding(.horizontal, 8)
                        .frame(width: varWidth, height: 50).border(Color.black, width: 2)
                        .background(.white)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    Spacer()
                    
                    Button(action: {
                        AuthViewModel().phoneSignIn(phoneNumber: phoneText, username: usernameText, fullName: fullNameText, credential: user_credentials!)
                        isNavigationBarHidden.toggle()
                        //                        isLoading.toggle()
                        
                        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        if usernameText == "aali183" {
                            isAdminPage.toggle()
                        } else {
                            isUserPage.toggle()
                        }
                        //                        }
                        
                    }) {
                        HStack {
                            Text("Lets Go!").font(.title3).frame(width: varWidth, height: 50)
                        }
                    }
                    .disabled(isFullNameEmpty)
                    .background(isFullNameEmpty ? Color.gray : Color("Primary_color"))
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .padding(.vertical)
                    .navigationDestination(isPresented: $isAdminPage) {
                        withAnimation(.easeIn(duration: 2)) {
                            BottomNavbar()
                                .navigationBarHidden(true)
                        }
                    }
                    .navigationDestination(isPresented: $isUserPage) {
                        withAnimation(.easeIn(duration: 4)) {
                            FeedPage(isShownFirstFeed: true)
                                .navigationBarHidden(true)
                        }
                    }
                    //                .navigationDestination(isPresented: $isHomePage) {
                    //                    FeedPage().navigationBarBackButtonHidden(true)
                    //                }
                    // Add error check for admin user redirection
                }
                .foregroundColor(.black)
                .frame(height: varHeight)
            }
            .navigationBarHidden(isNavigationBarHidden)
        }
        
    }
}

//struct UserDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetails()
//    }
//}
