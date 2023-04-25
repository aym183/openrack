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
        StripeAPI.defaultPublishableKey = "pk_test_51LcPpgJ4NNUHuKH8CVncZseI96JVxtbDzpEGLuKbM1dDOLCigYJXC9MTwNUZTYjoGpLPuTax7gbMb4NpQVlXkex000vVNrubiU"
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AuthViewModel()
            LandingPage().environmentObject(viewModel)
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
                    print("Audio Time")
        }
      return true
  }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
    }
    
    
    // This method handles opening universal link URLs (for example, "https://example.com/stripe_ios_callback")
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool  {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let stripeHandled = StripeAPI.handleURLCallback(with: url)
                if (stripeHandled) {
                    return true
                } else {
                    // This was not a Stripe url – handle the URL normally as you would
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
        } else {
            // This was not a Stripe url – handle the URL normally as you would
        }
        
        return GIDSignIn.sharedInstance.handle(url)
    }
}
