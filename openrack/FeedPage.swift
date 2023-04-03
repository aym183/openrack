//
//  HomePage.swift
//  openrack
//
//  Created by Ayman Ali on 30/03/2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct FeedPage: View {
    var body: some View {
           VideoPlayerView(videoURL: URL(string: "http://stream.mux.com/XZC6aDM1CxYjFf9C2bxLe7E8JHQ2mj00qjY01NhbNIu2M.m3u8")!)
               .frame(height: 300)
       }
}

struct FeedPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedPage()
    }
}

struct VideoPlayerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = AVPlayerViewController

    var videoURL: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = true
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update view controller
    }
}
