//
//  openrackApp.swift
//  openrack
//
//  Created by Ayman Ali on 26/03/2023.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import AVFoundation
import HaishinKit

@main
struct openrackApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
//            CreatorShow()
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
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
