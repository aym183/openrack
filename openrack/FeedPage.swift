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
    @State var showingBottomSheet = false
    @State var isShowingNextView = false
    @State var isBookmarked = false
    @State var isShownShow = false
    var rows: [GridItem] = [
        GridItem(.flexible() , spacing: nil, alignment: nil),
    ]
//    var viewerShows = UserDefaults.standard.array(forKey: "viewer_shows") as? [[String: Any]]
//    var viewerScheduledShows = UserDefaults.standard.array(forKey: "viewer_scheduled_shows") as? [[String: Any]]
    @AppStorage("email") var userEmail: String = ""
    @AppStorage("username") var userName: String = ""
    @StateObject var readListing = ReadDB()
    @State var isShownFeed = true
    
    var body: some View {
        var noOfShows = readListing.viewerShows?.count ?? 0
        var noOfScheduledShows = readListing.viewerScheduledShows?.count ?? 0
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                if isShownFeed {
                    VStack {
                        ProgressView()
                            .scaleEffect(2.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        
                        Text("Getting Openrack Ready! 🥳").fontWeight(.semibold).multilineTextAlignment(.center).padding(.top, 30).padding(.horizontal).foregroundColor(.black)
                    }
                }
                
                VStack {
                    CustomNavbarView()
                    
                    HStack {
                        Text("Live Shows")
                        Spacer()
                    }
                    .foregroundColor(.black).fontWeight(.semibold).font(Font.system(size: 20)).opacity(0.7).multilineTextAlignment(.leading).padding(.horizontal).padding(.bottom, -12)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 20) {
                            
                            ForEach(0..<noOfShows, id: \.self ) { index in
                                
                                NavigationStack {
                                    VStack (alignment: .leading){
                                        Button(action: {
                                            isShownShow.toggle()
                                            print(readListing.viewerShows![index])
                                            print(index)
                                        }) {
                                            VStack (alignment: .leading){
                                                
                                                HStack {
                                                    // Use Async Images instead of Image when using url's
                                                    Image(systemName: "livephoto").foregroundColor(Color.red)
                                                    Text("Live")
                                                        .fontWeight(.semibold).foregroundColor(Color.white).padding(.leading, -6)
                                                    Spacer()
                                                    Button(action: {isBookmarked.toggle()}) {
                                                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark").foregroundColor(Color.white)
                                                    }
                                                    
                                                }
                                                .padding(.horizontal, 3)
                                                .frame(width: 170)
                                                
                                                Spacer()
                                                Text(String(describing:readListing.viewerShows![index]["name"]!)).font(Font.system(size: 15)).fontWeight(.semibold).foregroundColor(Color.white).multilineTextAlignment(.leading).padding(.horizontal, 5)
                                            }
                                            .padding(.vertical, 10)
                                            .frame(width: 175, height: 240)
                                            .background(Image("ShowPreview").resizable())
                                            .cornerRadius(10.0)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 2)
                                            )
                                        } //Button
                                        .navigationDestination(isPresented: $isShownShow) {
                                            //                            ViewerShow(username:viewerShows![index]["created_by"]!, playbackID: viewerShows![index]["playback_id"]!, listingID: viewerShows![index]["listings"]!).navigationBarHidden(true)
                                            ViewerShow(retrievedShow: readListing.viewerShows![index]).navigationBarBackButtonHidden(true)
                                        }
                                        
                                        HStack {
                                            Image(systemName:"person.crop.circle")
                                            Text(String(describing:readListing.viewerShows![index]["created_by"]!)).fontWeight(.medium).padding(.leading, -5)
                                        }
                                        .font(Font.system(size: 15))
                                        .foregroundColor(.black)
                                    }
                                    .id(index)
                                }
                            }
                            
                            
                        }
                        .padding(.horizontal, 15)
                    }
                    .frame(height: 300)
                    
                    if userName != "aali183" {
                        
                        HStack {
                            Text("Upcoming Shows")
                            Spacer()
                        }
                        .foregroundColor(.black).fontWeight(.semibold).font(Font.system(size: 20)).opacity(0.7).multilineTextAlignment(.leading).padding(.horizontal).padding(.bottom, 0)
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, spacing: 20) {
                                // Change to length of response array
                                
                                ForEach(0..<noOfScheduledShows, id: \.self) { index in
                                    
                                    NavigationStack {
                                        VStack (alignment: .leading){
                                            Button(action: {}) {
                                                VStack (alignment: .leading){
                                                    
                                                    HStack {
                                                        // Use Async Images instead of Image when using url's
                                                        Text(MiscData().getSubstring(input: String(describing:readListing.viewerScheduledShows![index]["date_scheduled"]!)))
                                                            .fontWeight(.semibold).foregroundColor(Color.white).font(Font.system(size: 12))
                                                        Spacer()
                                                        Button(action: {isBookmarked.toggle()}) {
                                                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark").foregroundColor(Color.white)
                                                        }
                                                        
                                                    }
                                                    .padding(.horizontal, 3)
                                                    .frame(width: 170)
                                                    
                                                    Spacer()
                                                    Text(String(describing:readListing.viewerScheduledShows![index]["name"]!)).font(Font.system(size: 15)).fontWeight(.semibold).foregroundColor(Color.white).multilineTextAlignment(.leading).padding(.horizontal, 5)
                                                }
                                                .padding(.vertical, 10)
                                                .frame(width: 175, height: 260)
                                                .background(Image("ShowPreview").resizable())
                                                .cornerRadius(10.0)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 2)
                                                )
                                            } //Button
                                            HStack {
                                                Image(systemName:"person.crop.circle")
                                                Text(String(describing:readListing.viewerScheduledShows![index]["created_by"]!)).fontWeight(.medium).padding(.leading, -5)
                                            }
                                            .font(Font.system(size: 15))
                                            .foregroundColor(.black)
                                        }
                                        .id(index)
                                    }
                                }
                                
                            }
                            .padding(.horizontal, 15).padding(.top, 0)
                        }
                        .frame(height: 300)
                    }
                    
                    Spacer()
                    
                    
                    
                    
                    if userName == "aali183" {
                        Button(action: { showingBottomSheet.toggle() }, label: {
                            Text("+")
                                .font(.system(.largeTitle)).frame(width: 50, height: 40)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 7)
                        })
                        .background(Color("Primary_color"))
                        .cornerRadius(38.5)
                        .padding(.bottom, -15)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                }
                .background(Color("Secondary_color"))
                .sheet(isPresented: $showingBottomSheet) {
                    StreamBottomSheet(showingBottomSheet: $showingBottomSheet, isShowingNextView: $isShowingNextView)
                        .presentationDetents([.height(200)])
                }
                .navigationDestination(isPresented: $isShowingNextView) {
                    ScheduleStream().navigationBarHidden(true)
                }
                .onAppear {
                    readListing.getViewerLiveShows()
                    readListing.getViewerScheduledShows()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isShownFeed = false
                    }
                }
                .opacity(isShownFeed ? 0 : 1)
            }
            
        }
//        .onAppear {
//            print(viewerScheduledShows)
//            print(viewerShows)
//        }
        
    }
}

struct FeedPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedPage()
    }
}
