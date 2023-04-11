//
//  ViewerShow.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//

import SwiftUI
import AVKit

struct ViewerShow: View {
// https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8
    let playbackID: String
    let playerController = AVPlayerViewController()
    
    var body: some View {
        let player = AVPlayer(url: URL(string: "https://stream.mux.com/\(playbackID).m3u8")!)
        ZStack {
            VideoPlayer (player: player)
                .ignoresSafeArea()
                .disabled(true)
                .onAppear() { player.play() }
//                .allowsHitTesting(false)
                          
            
            VStack {
                
                HStack {
                    Image(systemName: "person.circle").font(Font.system(size: 25))

                    Text("username").font(Font.system(size: 20))
                    
                    
                    Spacer()
                    
                    Circle()
                        .fill(.red)
                        .frame(height: 30)
                        .overlay(
                            Image(systemName: "livephoto").font(Font.system(size: 20)).foregroundColor(.white)
                        )
                    
                    Text("45").font(Font.system(size: 15))
                        .padding(.trailing)

                    
                }
                .foregroundColor(.white)
                .fontWeight(.semibold)
                
                HStack {
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Primary_color"))
                            .frame(width: 50, height: 20)
                            .overlay(
                                Text("Follow").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                            )
                    }
                    Spacer()
                }
                    
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
                                        Image(systemName: "link").font(Font.system(size: 20)).foregroundColor(.white)
                                    )
                            }
                            
                            Text("Share").font(Font.system(size: 15)).fontWeight(.semibold)
                            
                            Button(action: {}) {
                                Circle()
                                    .fill(Color("Primary_color"))
                                    .frame(height: 50)
                                    .opacity(0.7)
                                    .overlay(
                                        Image(systemName: "creditcard.fill").font(Font.system(size: 20)).foregroundColor(.white)
                                    )
                            }
                        
                            Text("Pay").font(Font.system(size: 15)).fontWeight(.semibold)
                        }
                        .padding(.vertical, 50).padding(.trailing)
                        .foregroundColor(.white)
                    }
                    
                HStack{
                    Button(action: { }) {
                        Text("Buy It Now")
                            .font(.title3).fontWeight(.medium)
                            .frame(width: 300, height: 50)
                            .background(.white).foregroundColor(Color("Primary_color"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(50)
                            .padding(.horizontal)
                    }
                    
//                    Button(action: { }) {
//                        Text("Make Offer")
//                            .font(.title3).fontWeight(.medium)
//                            .frame(width: 100, height: 50)
//                            .background(.white).foregroundColor(Color("Primary_color"))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
//                            )
//                            .cornerRadius(50)
//                            .padding(.horizontal)
//                    }
                }
                    
                    
            }
            
            .frame(width: 370, height: 750)
        }
       
    }
}

//struct ViewerShow_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewerShow()
//    }
//}
