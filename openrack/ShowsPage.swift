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
    var retrievedShows: [[String: Any]]
//    @State var retrievedListings: [Any]
    var noOfShows: Int
    var allListingIDs: [String] = []
        
    init() {
        retrievedShows = UserDefaults.standard.array(forKey: "shows") as? [[String: Any]] ?? []
//        for index in retrievedShows {
//            self.allListingIDs.append(index["listings"] as! String)
//        }
        ReadDB().getListingIDs()
        noOfShows = retrievedShows.count ?? 0
        ReadDB().getListings()
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

                                ShowsPageButtons(retrievedShow: retrievedShows[index])
//                                String(describing: retrievedShows[index]["name"]!), stream_key: String(describing: retrievedShows[index]["stream_key"]!), stream_id: String(describing: retrievedShows[index]["livestream_id"]!), liveStreamID: String(describing: retrievedShows[index]["livestream_id"]!), listingID: String(describing: retrievedShows[index]["listings"]!)

                            }
                            .frame(width: 360, height: 110)
                            .border(Color.black, width: 2)
                            .background(.white)
                        }
                    }
                }
            }
            .padding(.horizontal)
//            .onAppear {
//
//            }
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


struct ShowsPage_Previews: PreviewProvider {
    static var previews: some View {
        ShowsPage()
    }
}
