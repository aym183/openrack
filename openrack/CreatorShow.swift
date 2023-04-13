//
//  CreatorShow.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//

import SwiftUI

import SwiftUI
import AVKit
import HaishinKit

struct CreatorShow: View {
//https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8
    let player = AVPlayer(url: URL(string: "https://www.google.com")!)
    let playerController = AVPlayerViewController()
    let rtmpConnection = RTMPConnection()
    @State private var streamButtonText = "Start Stream"
    @State private var isStreaming = false
    var streamName: String
    var streamKey: String
    
//    @State var rtmpStream: RTMPStream?
//    private var defaultCamera: AVCaptureDevice.Position = .front
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    @StateObject private var model = FrameHandler()

        var body: some View {
              ZStack {
//                VideoPlayer (player: player)
//                    .ignoresSafeArea()
//                    .disabled(true)
//                    .onAppear() { player.play() }
//                .allowsHitTesting(false)
                  
                  FrameView(image: model.frame)
                                  .frame(maxWidth: .infinity, maxHeight: .infinity)


                VStack {

                    HStack {

                        Text(streamName).font(Font.system(size: 20))


                        Spacer()

                        Circle()
                            .fill(.red)
                            .frame(height: 30)
                            .overlay(
                                Image(systemName: "record.circle").font(Font.system(size: 20)).foregroundColor(.white)
                            )

                        Text("15:00").font(Font.system(size: 15))
                            .padding(.trailing)


                        Circle()
                            .fill(Color("Primary_color"))
                            .frame(height: 30)
                            .overlay(
                                Image(systemName: "person.fill").font(Font.system(size: 20)).foregroundColor(.white)
                            )

                        Text("45").font(Font.system(size: 15))
                            .padding(.trailing)


                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)


                    Spacer()

                    HStack {
                            Spacer()
                            VStack {

                                Button(action: {}) {
                                    Circle()
                                        .fill(Color("Primary_color"))
                                        .frame(height: 50)
                                        .opacity(0.7)
                                        .overlay(
                                            Image(systemName: "dollarsign.circle").font(Font.system(size: 25)).foregroundColor(.white)
                                        )
                                }

                                Text("Sales").font(Font.system(size: 15)).fontWeight(.semibold) // Should show item sold to who, price, and shipping details


                                Button(action: {}) {
                                    Circle()
                                        .fill(Color("Primary_color"))
                                        .frame(height: 50)
                                        .opacity(0.7)
                                        .overlay(
                                            Image(systemName: "link").font(Font.system(size: 20)).foregroundColor(.white)
                                        )
                                }

                                Text("Share").font(Font.system(size: 15)).fontWeight(.semibold)

                                Button(action: { }) {
                                    Circle()
                                        .fill(Color("Primary_color"))
                                        .frame(height: 50)
                                        .opacity(0.7)
                                        .overlay(
                                            Image(systemName: "gear").font(Font.system(size: 20)).foregroundColor(.white)
                                        )
                                }

                                Text("Settings").font(Font.system(size: 15)).fontWeight(.semibold) // Where creators can decide whether audience can bid or buy straight for an item, set timer for each item // Creators should be able to see each offer and choose to accept/deny
                            }
                            .padding(.vertical, 50).padding(.trailing)
                            .foregroundColor(.white)
                        }

                    HStack{
                        Button(action: {
                            if self.streamButtonText != "Start Stream" {
                                sessionQueue.async {
                                    model.closeStream()
                                }
                            } else {
                                isStreaming.toggle()
                                self.streamButtonText = "Stop Stream"
                                sessionQueue.async {
                                    model.publishStream()
                                }
                            }
                            
                            
                            
                            
                        }) {
                            Text(streamButtonText) // Should popup to add catalogue
                                .font(.title3).fontWeight(.medium)
                                .frame(width: 300, height: 50)
                                .background(isStreaming ? Color.white : Color.red)
                                .foregroundColor(isStreaming ? Color.red : Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                                )
                                .cornerRadius(50)
                                .padding(.horizontal)
                        }

                    }


                }

                .frame(width: 370, height: 750)
            }
        }

}

//struct CreatorShow_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatorShow()
//    }
//}
