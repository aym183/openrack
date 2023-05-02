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
    @State var showCircle = false
    @State var showingBottomSheet = false
    @State var showingSalesSheet = false
    var streamName: String
    var streamKey: String
    var liveStreamID: String
    var listingID: String
    @State var countdownTimer = 3
    @State var timerRunning = false
    @State var isTimerShown = false
    let timer = Timer.publish(every:1, on: .main, in: .common).autoconnect()
    @Binding var listingSelected: Listing
    @StateObject var readListing = ReadDB()
    @State var showConfirmationOrder = false
    @State var commentText = ""
    @AppStorage("username") var userName: String = ""
    
//    @State var rtmpStream: RTMPStream?
//    private var defaultCamera: AVCaptureDevice.Position = .front
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    @StateObject private var model = FrameHandler()

        var body: some View {
            var noOfComments = readListing.comments?.count ?? 0
            ZStack {
                
                  FrameView(image: model.frame)
                                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                                  .ignoresSafeArea()

                if isTimerShown {
                    Text("\(countdownTimer)").font(Font.system(size: 100)).opacity(0.7).foregroundColor(.white)
                        .onReceive(timer) { _ in
                            if countdownTimer > 0 && timerRunning {
                                countdownTimer -= 1
                            } else {
                                timerRunning = false
                                isTimerShown = false
                            }
                        }
                }


                VStack {

                    HStack {

                        Text(streamName).font(Font.system(size: 20))


                        Spacer()

                        if showCircle {
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

                            Text("0").font(Font.system(size: 15))
                                .padding(.trailing)
                        }
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)


                    Spacer()

                    HStack {
                        ScrollViewReader { proxy in
                            
                            VStack{
                                ScrollView(.vertical, showsIndicators: false) {
                                    if readListing.comments != [] {
                                        
                                        ForEach(0..<noOfComments, id: \.self) { index in
                                            HStack {
                                                VStack(alignment: .leading,spacing: 0) {
                                                    
                                                    Text(String(describing: readListing.comments![index]["username"]!)).font(Font.system(size: 11)).fontWeight(.bold).padding(.top,10)
                                                    
                                                    Text(String(describing: readListing.comments![index]["comment"]!)).font(Font.system(size: 14)).fontWeight(.medium).padding(.top,2)
                                                }
                                                .padding(.leading, 5)
                                                Spacer()
                                            }
                                            .fontWeight(.semibold)
                                            .id(index)
                                        }
                                        .foregroundColor(.white)
                                        .onAppear {
                                            withAnimation(.easeOut(duration: 0.5)) {
                                                proxy.scrollTo(noOfComments-1, anchor: .bottom)
                                            }
                                        }
                                        //                                    .onReceive(readListing.$comments) { _ in
                                        //                                        withAnimation(.easeOut(duration: 0.5)) {
                                        //                                            proxy.scrollTo(noOfComments-1, anchor: .bottom)
                                        //                                        }
                                        //                                    }
                                    }
                                }
                                .frame(width: 250, height: 200)
                                .cornerRadius(10)
                                .padding(.leading,5).padding(.top, 70).padding(.bottom)
                                
                                TextField ("", text: $commentText, prompt: Text("Say Something...").foregroundColor(.white).font(Font.system(size: 12)))
                                    .padding(.horizontal)
                                    .foregroundColor(.white).font(Font.system(size: 12))
                                    .frame(width: 130, height: 37)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2)
                                    )
                                    .opacity(0.7)
                                    .padding(.bottom, 50).padding(.trailing, 100)
                                    .onSubmit {
                                        if commentText != "" {
                                            print(noOfComments)
                                            UpdateDB().updateComments(listingID: listingID, comment: commentText, username: userName)
                                            print(noOfComments)
                                            commentText = ""
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                withAnimation(.easeOut(duration: 0.5)) {
                                                    proxy.scrollTo(noOfComments, anchor: .bottom)
                                                }
                                            }
                                        }
                                    }
                            }
                            
                        }
                        
                            Spacer()
                            VStack {
                                
                                Button(action: { showingBottomSheet.toggle() }) {
                                    Circle()
                                        .fill(Color("Primary_color"))
                                        .frame(height: 50)
                                        .opacity(0.7)
                                        .overlay(
                                            Image(systemName: "tshirt.fill").font(Font.system(size: 25)).foregroundColor(.white)
                                        )
                                }

                                Text("Listings").font(Font.system(size: 15)).fontWeight(.semibold)

                                Button(action: { showingSalesSheet.toggle() }) {
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
                            .padding(.vertical, 40).padding(.trailing)
                            .foregroundColor(.white)
                        }

                    if readListing.title != nil && readListing.price != nil && readListing.isSold != true && readListing.highest_bid != nil && readListing.timer != nil {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(readListing.title!).font(Font.system(size: 18)).fontWeight(.bold)
                                
                                Text("🇦🇪 Shipping & Tax").font(Font.system(size: 12)).opacity(0.7)
                            }
                            
                            Spacer()
                            
                            Text("\(readListing.highest_bid! == "" ? readListing.price! : readListing.highest_bid!) AED")
                                .font(Font.system(size: 18)).fontWeight(.bold)
                            
                        }
                        .padding(.bottom)
                        .padding(.trailing)
                        .padding(.leading, 5)
                        .foregroundColor(Color.white)
                        
                        if readListing.type == "Auction" {
                            HStack {
                                Text(readListing.timer!).font(Font.system(size: 18)).fontWeight(.semibold)
                                Spacer()
                                Text(readListing.current_bidder!).font(Font.system(size: 18)).fontWeight(.semibold)
                            }
                            .padding(.bottom).padding(.top, 0)
                            .padding(.trailing)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        }
                        
                    } else if readListing.isSold == true {
                        Text("")
                            .onAppear {
                                showConfirmationOrder.toggle()
                            }
                    }
                    HStack{
                        Button(action: {
                            if self.streamButtonText != "Start Stream" {
                                sessionQueue.async {
                                    model.closeStream()
                                }
                                UpdateDB().updateStatus(text: "Finished", livestreamID: liveStreamID)
                            } else {
                                isTimerShown.toggle()
                                timerRunning.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    isStreaming.toggle()
                                    showCircle.toggle()
                                    UpdateDB().updateStatus(text: "Live", livestreamID: liveStreamID)
                                    self.streamButtonText = "Stop Stream"
                                    sessionQueue.async {
                                        model.publishStream()
                                    }
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
                .onAppear{
                    readListing.getListingSelected(listingID: String(describing: listingID))
                    readListing.getCreatorSales(listingID: String(describing: listingID))
                }
            }
            .sheet(isPresented: $showingBottomSheet) {
                CreateListings(listingID: listingID, creatorView: true, listingSelected: $listingSelected)
                    .presentationDetents([.height(400)])
            }
            .sheet(isPresented: $showingSalesSheet) {
                SalesPage(sales: readListing.creatorSales!)
                    .presentationDetents([.height(400)])
            }
            .SPAlert(
                isPresent: $showConfirmationOrder,
                title: "Order Alert!",
                message: "\(readListing.title != nil ? readListing.title! : "Item") has been bought \(readListing.price != nil ? "for \(readListing.price!) AED!" : "!")",
                duration: 2.0,
                dismissOnTap: false,
                preset: .done,
                haptic: .success,
                layout: .init()
            )
        }

}

//struct CreatorShow_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatorShow()
//    }
//}
