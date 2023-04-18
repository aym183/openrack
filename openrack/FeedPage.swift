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
    var columns: [GridItem] = [
        GridItem(.flexible() , spacing: nil, alignment: nil),
        GridItem(.flexible() , spacing: nil, alignment: nil)
    ]
    var viewerShows = UserDefaults.standard.array(forKey: "viewer_shows") as? [[String: Any]]
    
    var body: some View {
        var noOfShows = viewerShows?.count ?? 0
        NavigationStack {
            VStack {
                CustomNavbarView()
                Spacer()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        // Change to length of response array
                        ForEach(0..<noOfShows) { index in
                            
                            NavigationStack {
                            VStack (alignment: .leading){
                                Button(action: {
                                    isShownShow.toggle()
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
                                        Text(String(describing:viewerShows![index]["name"]!)).font(Font.system(size: 15)).fontWeight(.semibold).foregroundColor(Color.white).multilineTextAlignment(.leading).padding(.horizontal, 5)
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
                                    Text(String(describing:viewerShows![index]["created_by"]!)).fontWeight(.medium).padding(.leading, -5)
                                }
                                .font(Font.system(size: 15))
                            }
                        }
                        .navigationDestination(isPresented: $isShownShow) {
//                            ViewerShow(username:viewerShows![index]["created_by"]!, playbackID: viewerShows![index]["playback_id"]!, listingID: viewerShows![index]["listings"]!).navigationBarHidden(true)
                                ViewerShow(retrievedShow: viewerShows![index]).navigationBarHidden(true)
                        }
                        
                        }
                    }
                    .padding(.horizontal,5).padding(.top)
                }


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
            .background(Color("Secondary_color"))
            .sheet(isPresented: $showingBottomSheet) {
                StreamBottomSheet(showingBottomSheet: $showingBottomSheet, isShowingNextView: $isShowingNextView)
                    .presentationDetents([.height(200)])
            }
            .navigationDestination(isPresented: $isShowingNextView) {
                ScheduleStream().navigationBarHidden(true)
            }
        }

        
    }
}

struct FeedPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedPage()
    }
}
