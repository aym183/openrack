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
    @AppStorage("username") var userName: String = ""
    @State var userIsLoggedIn = false
    var body: some View {
        ZStack {
            VStack {
                if userIsLoggedIn {
                    if userName == "aali183" {
                        BottomNavbar()
                    } else {
                        FeedPage(isShownFeed: true, isShownFirstFeed: false)
                    }
                } else {
                    LandingContent(userIsLoggedIn: $userIsLoggedIn)
                }
            }
        }
    }
    }

struct LandingContent: View {
    var signupVM = AuthViewModel()
    var authUIText = AuthUIViewModel()
    @State var showingPhoneBottomSheet = false
    @State var signedIn = false
    @Binding var userIsLoggedIn: Bool
    @Environment(\.presentationMode) var presentationMode
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
                        
                        Button(action: { showingPhoneBottomSheet.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
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
                    if Auth.auth().currentUser != nil {
                        userIsLoggedIn.toggle()
                    }
            }
            .fullScreenCover(isPresented: $shouldShowOnboarding , content: {
                OnboardingFlow(shouldShowOnboarding: $shouldShowOnboarding)
            })
        }
    }
}
