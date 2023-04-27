//
//  ViewerShow.swift
//  openrack
//
//  Created by Ayman Ali on 09/04/2023.
//
import SwiftUI
import AVKit
import Firebase

struct ViewerShow: View {
//https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8
    let retrievedShow: [String: Any]
//    let username: String
//    let playbackID: String
    let playerController = AVPlayerViewController()
    @AppStorage("email") var userEmail: String = ""
    @AppStorage("username") var userName: String = ""
//    let listingID: String
    @State var showingPaySheet = false
    @State var showingAddressSheet = false
    @State var isShowingPaymentsForm = false
    @State var isShowingAddressForm = false
    @State var showConfirmationOrder = false
    @State var showingFeedPage = false
    @State var currentBid = 0
    @StateObject var readListing = ReadDB()
    @State var updateDB = UpdateDB()
    @State var commentText = ""
    
    var body: some View {
        NavigationStack {
            let player = AVPlayer(url: URL(string: "https://stream.mux.com/\(retrievedShow["playback_id"]!).m3u8")!)
            ZStack {
                
                GeometryReader { geometry in
                    VideoPlayer (player: player)
                        .disabled(true)
                        .onAppear() { player.play() }
                    //                .allowsHitTesting(false)
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    HStack {
                        
                        Button(action: { showingFeedPage.toggle() }) {
                            Image(systemName: "arrow.backward").font(Font.system(size: 25)).fontWeight(.bold).foregroundColor(.white)
                            
                            Text(String(describing: retrievedShow["created_by"]!)).font(Font.system(size: 20))
                        }
                        
                        
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
                        ScrollView {
                            VStack {
                                ForEach(1..<20) { index in
                                    HStack {
                                        
                                        Image(systemName: "person.circle").font(Font.system(size: 20))
                                        
                                        VStack(alignment: .leading,spacing: 0) {
                                            Text("aym1302").font(Font.system(size: 13)).padding(.top,10)
                                            Text("Comment for me").font(Font.system(size: 16)).foregroundColor(Color("Primary_color"))
                                        }
                                        Spacer()
                                    }
                                    .fontWeight(.semibold)
                                    
                                }
                                .foregroundColor(.white)
                                
                            }
                            .frame(width: 250)
                            

                        }
                        .frame(width: 250, height: 200)
//                        .border(.white, width: 2)
                        .cornerRadius(10)
                        .padding(.leading,5).padding(.bottom)
                        
                        
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
                            
                            Button(action: { showingPaySheet.toggle() }) {
                                Circle()
                                    .fill(Color("Primary_color"))
                                    .frame(height: 50)
                                    .opacity(0.7)
                                    .overlay(
                                        Image(systemName: "creditcard.fill").font(Font.system(size: 20)).foregroundColor(.white)
                                    )
                            }
                            
                            Text("Pay").font(Font.system(size: 15)).fontWeight(.semibold)
                            
                            
                            Button(action: {}) {
                                Circle()
                                    .fill(Color("Primary_color"))
                                    .frame(height: 70)
                                    .opacity(0.7)
                                    .overlay(
                                        Image(systemName:"bag.fill")
                                            .font(Font.system(size: 35))
                                            .foregroundColor(.white)
                                    )
                            }
                            .padding(.top)
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.vertical, 40).padding(.trailing,10).padding(.bottom, -50)
                    
                    HStack {
                        TextField ("", text: $commentText, prompt: Text("Say Something...").foregroundColor(.white).font(Font.system(size: 12)))
                            .padding(.horizontal)
                            .foregroundColor(.white).font(Font.system(size: 12))
                            .frame(width: 130, height: 37)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2)
                            )
                            .opacity(0.7)
                            .padding(.bottom, 40)

                        
                        Spacer()
                    }.padding(.horizontal,10)

                    
                    
                    if readListing.title != nil && readListing.price != nil && readListing.isSold != true {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(readListing.title!)
                                    .font(Font.system(size: 18)).fontWeight(.bold)
                                
                                Text("🇦🇪 Shipping & Tax").font(Font.system(size: 12)).opacity(0.7)
                            }
                            
                            Spacer()
                            
                            Text("\(readListing.price!) AED")
                                .font(Font.system(size: 18)).fontWeight(.bold).padding(.trailing, 10)
                            
                        }
                        .padding(.bottom)
                        .padding(.horizontal)
                        .foregroundColor(Color.white)
                        
                    }
                    HStack{
                        
                        if readListing.type == "Auction" && readListing.price != nil && readListing.timer != nil  && readListing.isSold != true {
                            HStack {
                                Button(action: {
                                    readListing.price = "\(Int(readListing.price!)! + 5)"
                                    UpdateDB().updateHighestBid(listingID: String(describing: retrievedShow["listings"]!), bid: "\(Int(readListing.price!)! + 5)", bidder: userName)
                                    
                                   
                                    
//                                    else if readListing.timer! != "00:00" {
                                        updateDB.updateTimer(listingID: String(describing: retrievedShow["listings"]!), start_time: readListing.timer!, viewer_side: true)
//
//                                        Database.database().reference().child("shows").child(String(describing: retrievedShow["listings"]!)).child("selectedListing").child("timer").removeValue()
//
                                        
//                                    }
                                    
                                    // Insert timer function here
//                                    updateDB.updateTimer(listingID: String(describing: retrievedShow["listings"]!), start_time: readListing.timer!, viewer_side: true)
                                }) {
                                    
                                    
                                    HStack {
                                        Text("Place Bid").font(.title3).fontWeight(.semibold)
                                        Spacer()
                                        Text("\(Int(readListing.price!)! + 5)").font(Font.system(size: 18)).fontWeight(.bold)
                                    }
                                    .frame(width: 155, height: 45)
                                    .padding(.horizontal, 10)
                                }
                                .background((readListing.isSold != true) ? Color("Primary_color") : Color.gray)
                                .foregroundColor((readListing.isSold != true) ? Color.white : Color.white)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                                )
                                .cornerRadius(10)
                                .disabled(readListing.isSold != true ? false : true)
                                
                                Spacer()
                                
                                
                                Text(readListing.timer!).foregroundColor(.white).fontWeight(.semibold).font(Font.system(size: 18)).padding(.trailing, 10)
                                
                                
                            }
                            .padding([.horizontal,.bottom])
                            
                        } else {
                            
                            Button(action: {
                                ReadServer().executeOrderTransaction(order_amount: readListing.price!) { response in
                                    if response! == "success" {
                                        UpdateDB().updateListingSold(listingID: retrievedShow["listings"] as! String)
                                        showConfirmationOrder.toggle()
                                    }
                                }
                            }) {
                                Text("Buy Now")
                                    .font(.title3).fontWeight(.semibold)
                                    .frame(width: 300, height: 50)
                                    .padding(.trailing, 10)
                            }
                            .padding(.trailing, -20)
                            .background((readListing.isSold != true) ? Color("Primary_color") : Color.gray)
                            .foregroundColor((readListing.isSold != true) ? Color.white : Color.white)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2))
                            .cornerRadius(50)
                            .disabled(readListing.isSold != true ? false : true)
                            .padding(.bottom)
                            
                            
                        }
                        
                        //                    Button(action: { }) {
                        //                        Text("Make Offer")
                        //                            .font(.title3).fontWeight(.medium)
                        //                            .frame(width: 140, height: 50)
                        //                            .background(Color("Primary_color"))
                        //                            .foregroundColor(.white)
                        //                            .overlay(
                        //                                RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                        //                            )
                        //                            .cornerRadius(50)
                        //                            .padding(.horizontal)
                        //                    }
                    }
                    
                    
                    //                            .background(.white).foregroundColor(Color("Primary_color"))
                    //                            .overlay(
                    //                                RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2)
                    //                            )
                    //                            .cornerRadius(50)
                    //                            .padding(.horizontal)
                    //                    }
                    
                    
                }
                .frame(width: 370, height: 750)
                .onAppear{
                    print(String(describing: retrievedShow))
                    readListing.getListingSelected(listingID: String(describing: retrievedShow["listings"]!))
                }
                .onReceive(readListing.$timer) { timer in
                    if timer == "00:00" && userName == readListing.current_bidder {
                        print("Auction Ended")
                        
                        ReadServer().executeOrderTransaction(order_amount: readListing.price!) { response in
                                if response! == "success" {
                                    showConfirmationOrder.toggle()
                                    UpdateDB().updateListingSold(listingID: retrievedShow["listings"] as! String)
                                }
                            }
                    }
                }
                .sheet(isPresented: $showingPaySheet) {
                    PaymentDetails(showingPaySheet: $showingPaySheet, isShowingPaymentsForm: $isShowingPaymentsForm, isShowingAddressForm: $isShowingAddressForm)
                        .presentationDetents([.height(320)])
                }
                .navigationDestination(isPresented: $showingFeedPage) {
                    if userEmail != "ayman.ali1302@gmail.com" {
                        FeedPage()
                            .navigationBarBackButtonHidden(true)
                    } else {
                        BottomNavbar().navigationBarBackButtonHidden(true)
                    }
                }
            }
            
            .SPAlert(
                isPresent: $showConfirmationOrder,
                title: "Success!",
                message: "Your order has been placed",
                duration: 2.0,
                dismissOnTap: false,
                preset: .done,
                haptic: .success,
                layout: .init()
            )
        }
    }
}

struct ViewerShow_Previews: PreviewProvider {
    static var previews: some View {
        ViewerShow(retrievedShow: ["playback_id": "sdsds", "created_by": "test", "listings": "dacdads"])
    }
}
