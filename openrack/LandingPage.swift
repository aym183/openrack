//
//  ContentView.swift
//  openrack
//
//  Created by Ayman Ali on 26/03/2023.
//
import SwiftUI
import _AuthenticationServices_SwiftUI
import Firebase

struct LandingPage: View {
//    AppStorage("username")
//    : String
    
    @AppStorage("username") var userName: String = ""
    @State var userIsLoggedIn = false
    var body: some View {
        ZStack {
            VStack {
                if userIsLoggedIn {
                    if userName == "aali183" {
                        BottomNavbar()
                    } else {
                        FeedPage()
                    }
                } else {
                    LandingContent(userIsLoggedIn: $userIsLoggedIn)
                }
            }
        }
        .onAppear {
            print(userName)
        }
    }
    }

struct LandingContent: View {
    var signupVM = AuthViewModel()
    var authUIText = AuthUIViewModel()
    @State var showingPhoneBottomSheet = false
//    @State var showingSignInBottomSheet = false
//    @State var showingLoginBottomSheet = false
    @State var signedIn = false
    @Binding var userIsLoggedIn: Bool
    // ------ Add @AppStorage("shouldShowOnboarding") instead of @State to persist not showing onbaording after  user's tried ------
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                var varWidth = geometry.size.width - 10
                var varHeight = geometry.size.height - 20
                ZStack {
                    Color("Secondary_color").ignoresSafeArea()
                    VStack{
                        
                        Text("Openrack").font(Font.system(size: 70)).fontWeight(.heavy)
                            .foregroundColor(Color("Primary_color"))
                            .padding(.top, 120)
                            .padding(.horizontal, 10)
                        
                        Text("Buy, Sell, Discover ✨").font(Font.system(size: 20)).font(.subheadline).fontWeight(.semibold).foregroundColor(.black)
                            .opacity(0.7)
                        
                        
                        Spacer()
                        
                        //                    Text("A peer-to-peer marketplace to buy & sell fashion in MENA.").font(Font.system(size: 25)).fontWeight(.semibold)
                        //                        .foregroundColor(Color.black)
                        //                        .padding(.horizontal, 10.0).padding(.top, 50.0)
                        //                        .multilineTextAlignment(.center)
                        //
                        
                        Button(action: { showingPhoneBottomSheet.toggle() }) {
                            HStack {
                                Text("Get Started")
                                Image(systemName: "arrow.forward")
                            }
                            .font(Font.system(size: 25))
                            .fontWeight(.semibold)
                        }
                        .frame(width: 300, height: 55)
                        .background(Color.black).foregroundColor(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                        )
                        .cornerRadius(50)
                        .navigationDestination(isPresented: $showingPhoneBottomSheet) {
                            SignInEmailView(userDetails: authUIText.UIDetails(purpose: "Phone Sign In"))
                        }
                        .padding(.horizontal, 50)
                        
                        
                        //                    Button(action: { DispatchQueue.global().async { signupVM.signUpWithGoogle() } })
                        //                    {
                        //                        HStack{
                        //                            Image("Google_Logo")
                        //                            Text("Sign in with Google").font(.title3)
                        //                        }
                        //                    }
                        //                    .frame(width: 360, height: 50)
                        //                    .background(Color("Google_color")).foregroundColor(Color.white)
                        //                    .overlay(
                        //                        RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                        //                    )
                        //                    .cornerRadius(50)
                        //                    .padding(.horizontal)
                        
                        //                    Button(action: { showingSignInBottomSheet.toggle() }) {
                        //                        HStack {
                        //                            Image(systemName: "envelope.fill")
                        //                            Text("Sign in with Email").font(.title3)
                        //                        }
                        //                    }
                        //                    .frame(width: 360, height: 50)
                        //                    .background(Color("Primary_color")).foregroundColor(Color.white)
                        //                    .overlay(
                        //                        RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                        //                    )
                        //                    .cornerRadius(50)
                        //                    .padding(.horizontal)
                        //                    .navigationDestination(isPresented: $showingSignInBottomSheet) {
                        //                        SignInEmailView(userDetails: authUIText.UIDetails(purpose: "Email"))
                        //                    }
                        //
                        //                    Divider().frame(width: 300, height: 3).background(.black).padding(.top, 5).padding(.bottom, 5).opacity(0.7)
                        //
                        //                    Button(action: { showingLoginBottomSheet.toggle() }) {
                        //                        HStack {
                        //                            Image(systemName: "envelope.fill")
                        //                            Text("Login with Email").font(.title3)
                        //
                        //                        }
                        //                    }
                        //                    .frame(width: 360, height: 50)
                        //                    .background(.white).foregroundColor(.black)
                        //                    .overlay(
                        //                        RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                        //                    )
                        //                    .cornerRadius(50)
                        //                    .padding(.horizontal)
                        //                    .navigationDestination(isPresented: $showingLoginBottomSheet) {
                        //                        SignInEmailView(userDetails: authUIText.UIDetails(purpose: "Login"))
                        //                    }
                        
                        
                        //                    .sheet(isPresented: $showingLoginBottomSheet) { SignInEmailView(userDetails: authUIText.UIDetails(purpose: "Login")) }
                        
                        Text("By continuing you agree to our Terms of Service.\nOpenrack services are subject to our Privacy Policy.")
                            .foregroundColor(.black)
                            .font(.footnote).fontWeight(.semibold)
                            .padding(.horizontal).padding(.top, 20).padding(.bottom, 30)
                            .opacity(0.7)
                            .multilineTextAlignment(.center)
                        
                    }
                    .frame(width: varWidth, height: varHeight)
                }
            }
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        print("User is \(user)")
                        userIsLoggedIn.toggle()
                        
                    }
                }
            }
            // ------ Add to replace loginview ka bs and add bottomcard ? ------
            .fullScreenCover(isPresented: $shouldShowOnboarding , content: {
                OnboardingFlow(shouldShowOnboarding: $shouldShowOnboarding)
            })
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        LandingPage().previewDevice("iPhone 14 Pro")
        LandingPage().previewDevice("iPhone 12 Pro")
//        LandingPage().previewDevice("iPhone 11")
//        LandingPage().previewDevice("iPhone SE")
//        LandingPage().previewDevice("iPhone X")
    }
}
