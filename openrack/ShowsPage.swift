//
//  ShowsPage.swift
//  openrack
//
//  Created by Ayman Ali on 07/04/2023.
//
import SwiftUI
import Foundation

struct ShowsPage: View {
    var columns: [GridItem] = [
        GridItem(.flexible() , spacing: nil, alignment: nil)
    ]
//    var retrievedShows = UserDefaults.standard.array(forKey: "shows") as? [[String: Any]]
    var retrievedShows: [[String: Any]]
    var noOfShows: Int
        
    init() {
        retrievedShows = UserDefaults.standard.array(forKey: "shows") as? [[String: Any]] ?? []
        noOfShows = retrievedShows.count ?? 0
    }
    
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack (alignment: .leading) {

                Text("Shows").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20).foregroundColor(.black)
                Spacer()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        // Change to length of response array
//                        noOfShows
                        ForEach(0..<noOfShows) { index in
                            VStack {
                                
                                showName(name: String(describing: retrievedShows[index]["name"]!), status: String(describing: retrievedShows[index]["status"]!), date_sched: String(describing: retrievedShows[index]["date_scheduled"]!), description: String(describing: retrievedShows[index]["description"]!))

                                showButtons(name: String(describing: retrievedShows[index]["name"]!), stream_key: String(describing: retrievedShows[index]["stream_key"]!), stream_id: String(describing: retrievedShows[index]["livestream_id"]!), liveStreamID: String(describing: retrievedShows[index]["livestream_id"]!))

                            }
                            .frame(width: 360, height: 110)
                            .border(Color.black, width: 2)
                            .background(.white)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct showName: View {
    var name: String!
    var status: String!
    var date_sched: String!
    var description: String!
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorSelector().getStatusColor(status: status))
                .frame(width: 60, height: 20)
                .overlay(
                    Text(status).textCase(.uppercase).font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                )

            Text(name)
                .font(Font.system(size: 12))
                .fontWeight(.semibold)


            Spacer()

            Text(date_sched).font(Font.system(size: 12))

        }
        .padding(.horizontal,6)
        .foregroundColor(.black)
        
        Text(description).font(Font.system(size: 12)).frame(width: 345, height: 30).foregroundColor(.black)
    }
}

struct showButtons: View {
    var name: String!
    var stream_key: String!
    var stream_id: String!
    var liveStreamID: String!
    
    @State var streamStarted = false
    var body: some View {
        HStack {
            Button(action: {
                ReadDB().getStreamKey(liveStreamID: stream_id)
                streamStarted.toggle()
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
                    .frame(width: 95, height: 30)
                    .overlay(
                        Text("Start Streaming").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                    )
            }
            .navigationDestination(isPresented: $streamStarted) {
                CreatorShow(streamName: name, streamKey: stream_key, liveStreamID: liveStreamID).navigationBarHidden(true)
            }

            Button(action: {}) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black)
                    .frame(width: 80, height: 30)
                    .overlay(
                        HStack{
                            Image(systemName: "link").font(Font.system(size: 10)).padding(.trailing, -5)
                            Text("Copy Link").font(Font.system(size: 10)).fontWeight(.semibold)
                        }
                            .foregroundColor(.white)
                    )
            }
            Button(action: { print(index) }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: 78, height: 26)
                    .overlay(
                        Text("Cancel Stream").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.red)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                            .frame(width: 81.5, height: 30)
                    )
            }


            Spacer()
        }
        .padding(.horizontal,6).padding(.top, 0)
        .foregroundColor(.black)
    }
}
struct ShowsPage_Previews: PreviewProvider {
    static var previews: some View {
        ShowsPage()
    }
}
