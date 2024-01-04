//
//  openrackApp.swift
//  openrack
//
//  Created by Ayman Ali on 26/03/2023.
//
import SwiftUI
import FirebaseCore
import Firebase
import GoogleSignIn
import AVFoundation
import HaishinKit
import Stripe

@main
struct openrackApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        StripeAPI.defaultPublishableKey = "test"
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AuthViewModel()
            LandingPage().environmentObject(viewModel).preferredColorScheme(.dark)
        }
        
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .voiceChat, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
        } catch {
            print("Error")
        }
      return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let firebaseAuth = Auth.auth()
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let firebaseAuth = Auth.auth()
        if (firebaseAuth.canHandleNotification(userInfo)){
            print(userInfo)
            return
        }
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool  {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let stripeHandled = StripeAPI.handleURLCallback(with: url)
                if (stripeHandled) {
                    return true
                }
            }
        }
        return false
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        let stripeHandled = StripeAPI.handleURLCallback(with: url)
        if (stripeHandled) {
            print("Stripe Handled")
        }
        return GIDSignIn.sharedInstance.handle(url)
    }
}
