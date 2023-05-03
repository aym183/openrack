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
    
    // could be what's making the discrepancy in viewer show, try passing listing id akele as a parameter
    let retrievedShow: [String: Any]
    var index: Int?
//    let username: String
//    let playbackID: String
    let playerController = AVPlayerViewController()
    @AppStorage("username") var userName: String = ""
//    let listingID: String
    @State var showingPaySheet = false
    @State var showingPayDetailsError = false
    @State var showingAddressSheet = false
    @State var isShowingPaymentsForm = false
    @State var isShowingAddressForm = false
    @State var showConfirmationOrder = false
    @State var showingFeedPage = false
    @State var currentBid = 0
    @StateObject var readListing = ReadDB()
    @State var updateDB = UpdateDB()
    @State var commentText = ""
    @State var showStart = true
    @State private var opacity = 0.5


    
    var body: some View {
                
        var noOfComments = readListing.comments?.count ?? 0
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 30
            var varCommentsWidth = geometry.size.width - 140
            var varHeight = geometry.size.height - 10
            NavigationStack {
                let player = AVPlayer(url: URL(string: "https://stream.mux.com/\(retrievedShow["playback_id"]!).m3u8")!)

                ZStack {
                    Color("Primary_color").ignoresSafeArea()

                    if showStart {
                        VStack {
                            Spacer()
                            Image("Logo").padding(.horizontal).opacity(opacity)
                            Spacer()
                        }
                        .onAppear {
                            withAnimation(Animation.easeIn(duration: 1)) { self.opacity = 1.0 }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation{ self.showStart = false }
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    
                    
                    GeometryReader { newgeometry in
                        VideoPlayer (player: player)
                            .onAppear { player.play() }
                            .ignoresSafeArea()
//                            .disabled(true)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(showStart ? 0 : 1)
                    


                    VStack {
                        HStack {
                            Button(action: { showingFeedPage.toggle() }) {
                                Image(systemName: "arrow.backward").font(Font.system(size: 25)).fontWeight(.bold).foregroundColor(.white)

                                Text(String(describing: retrievedShow["created_by"]!)).font(Font.system(size: 20))
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2).opacity(0)
                            )


                            Spacer()

                            Circle()
                                .fill(.red)
                                .frame(height: 30)
                                .overlay(
                                    Image(systemName: "livephoto").font(Font.system(size: 20)).foregroundColor(.white)
                                )
                                .padding(.trailing)

                            //                        Text("Live").font(Font.system(size: 15)).foregroundColor(.red)
                            //                            .padding(.trailing)
                            //

                        }
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.top, -10).padding(.leading, 10)

                        Spacer()

                        HStack {
                            //                            VStack {
                            ScrollViewReader { proxy in

                                VStack{
                                    ScrollView(.vertical, showsIndicators: false) {
                                        if readListing.comments != [] {

                                            ForEach(0..<noOfComments, id: \.self) { index in
                                                HStack {
                                                    VStack(alignment: .leading,spacing: 0) {
                                                        Text(String(describing: readListing.comments![index]["username"]!)).font(Font.system(size: 11)).fontWeight(.bold).padding(.top,10)

                                                        //                                                        if readListing.comments![index]["username"]! == retrievedShow["created_by"]! {
                                                        //                                                            Text(String(describing: readListing.comments![index]["comment"]!)).font(Font.system(size: 14)).fontWeight(.medium).padding(.top,2).foregroundColor("Primary_color")
                                                        //                                                        } else {
                                                        Text(String(describing: readListing.comments![index]["comment"]!)).font(Font.system(size: 14)).fontWeight(.medium).padding(.top,2)
                                                        //                                                        }

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
                                    .padding(.leading,5).padding(.bottom)

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
                                                UpdateDB().updateComments(listingID: String(describing: retrievedShow["listings"]!), comment: commentText, username: userName)
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
                            //                            }
                            //                            .frame(width: 250)


                            //                            // Scroll to the bottom when the view appears
                            //                            DispatchQueue.main.async {
                            //                                withAnimation {
                            //                                    index.scrollTo(19)
                            ////                                    ScrollViewProxy.scrollTo(19, anchor: .bottom)
                            //                                }
                            //                            }
                            //                        }


                            Spacer()
                            VStack {

                                Button(action: {}) {
                                    Circle()
                                        .fill(Color("Primary_color"))
                                        .frame(height: 50)
                                        .overlay(
                                            Image(systemName: "link").font(Font.system(size: 20)).foregroundColor(.white)
                                        )
                                }

                                Text("Share").font(Font.system(size: 15)).fontWeight(.semibold)

                                Button(action: { showingPaySheet.toggle() }) {
                                    Circle()
                                        .fill(Color("Primary_color"))
                                        .frame(height: 50)
                                        .overlay(
                                            Image(systemName: "creditcard.fill").font(Font.system(size: 20)).foregroundColor(.white)
                                        )
                                }

                                Text("Pay").font(Font.system(size: 15)).fontWeight(.semibold)


//                                Button(action: {}) {
//                                    Circle()
//                                        .fill(Color("Primary_color"))
//                                        .frame(height: 70)
//                                        .overlay(
//                                            Image(systemName:"bag.fill")
//                                                .font(Font.system(size: 35))
//                                                .foregroundColor(.white)
//                                        )
//                                }
//                                .padding(.top)
                            }
                            .foregroundColor(.white)
                        }
                        .padding(.vertical, 10).padding(.trailing,10)

                      
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
                                        if readListing.address == nil && readListing.cardDetails == nil {
                                            showingPayDetailsError.toggle()
                                        }
                                        else {
                                            readListing.price = "\(Int(readListing.price!)! + 5)"
                                            UpdateDB().updateHighestBid(listingID: String(describing: retrievedShow["listings"]!), bid: "\(Int(readListing.price!)! + 5)", bidder: userName)
                                        }
                                    }) {


                                        HStack {
                                            Text("Place Bid").font(.title3).fontWeight(.semibold)
                                            Spacer()
                                            Text("\(Int(readListing.price!)! + 5)").font(Font.system(size: 18)).fontWeight(.bold)
                                        }
                                        .frame(width: 155, height: 45)
                                        .padding(.horizontal, 15)
                                    }
                                    .background((readListing.isSold != true) ? Color("Primary_color") : Color.gray)
                                    .foregroundColor((readListing.isSold != true) ? Color.white : Color.white)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2)
                                    )
                                    .cornerRadius(30)
                                    .disabled(readListing.isSold != true ? false : true)

                                    Spacer()


                                    Text(readListing.timer!).foregroundColor(.white).fontWeight(.semibold).font(Font.system(size: 18)).padding(.trailing, 10)


                                }
                                .padding(.trailing).padding(.leading, 5).padding(.bottom, 30)

                            } else {

                                Button(action: {
                                    if readListing.address == nil && readListing.cardDetails == nil {
                                        showingPayDetailsError.toggle()
                                    }
                                    else {
                                        showingPayDetailsError = false
                                        ReadServer().executeOrderTransaction(order_amount: readListing.price!) { response in
                                            if response! == "success" {
                                                showConfirmationOrder.toggle()
                                                UpdateDB().updateListingSold(listingID: retrievedShow["listings"] as! String)
                                                CreateDB().addUserOrders(item: readListing.title!, purchase_price: readListing.price!, buyer: userName)
                                                //                                            if readListing.creatorSales!.count == 0 {
                                                //                                                CreateDB().addCreatorSales(item: readListing.title!, purchase_price: readListing.price!, seller: String(describing: retrievedShow["created_by"]!), address: readListing.address!, listingID: String(describing: retrievedShow["listings"]!))
                                                //                                            } else {
                                                //                                                UpdateDB().updateCreatorSales(item: readListing.title!, purchase_price: readListing.price!, seller: String(describing: retrievedShow["created_by"]!), address: readListing.address!, listingID: String(describing: retrievedShow["listings"]!))
                                                //                                            }
                                            }
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
                                .padding(.bottom, 30)


                            }
                        }
                    }
                    .frame(width: varWidth, height: varHeight)
                    .onAppear{
                        readListing.getListingSelected(listingID: String(describing: retrievedShow["listings"]!))
                        readListing.getAddress()
                        readListing.getCardDetails()
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                            print(readListing.cardDetails)
//                            print(readListing.address)
//                        }
//                        readListing.getCreatorSales(listingID: String(describing: retrievedShow["listings"]!))
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
                        PaymentDetails(showingPaySheet: $showingPaySheet, isShowingPaymentsForm: $isShowingPaymentsForm, isShowingAddressForm: $isShowingAddressForm, readListing: readListing)
                            .presentationDetents([.height(320)])
                    }
                    .sheet(isPresented: $showingPayDetailsError) {
                        PaymentDetailsError().presentationDetents([.height(200)])
                    }
                    .navigationDestination(isPresented: $showingFeedPage) {
                        if userName != "aali183" {
//                            FeedPage(isShownFeed: false)
                            LandingPage().navigationBarBackButtonHidden(true)
                        } else {
                            BottomNavbar(isShownFeed: false).navigationBarBackButtonHidden(true)
                        }
                    }
                    .padding(.bottom, 10)
                    .opacity(showStart ? 0 : 1)
                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
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
}

struct ViewerShow_Previews: PreviewProvider {
    static var previews: some View {
        ViewerShow(retrievedShow: ["playback_id": "sdsds", "created_by": "test", "listings": "dacdads"])
    }
}
