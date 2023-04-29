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
    @StateObject var readListing = ReadDB()
//    var retrievedShows: [[String: Any]]
//    @State var retrievedListings: [Any]
    var allListingIDs: [String] = []
        
//    init() {
//
////        for index in retrievedShows {
////            self.allListingIDs.append(index["listings"] as! String)
////        }
//        ReadDB().getListingIDs()
//        ReadDB().getListings()
//    }
    
    var body: some View {
        var noOfShows = readListing.creatorShows!.count ?? 0
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                VStack (alignment: .leading) {
                    
                    Text("Shows").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20).foregroundColor(.black)
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            // Change to length of response array
                            //                        noOfShows
                            ForEach(0..<noOfShows, id: \.self) { index in
                                VStack {
                                    
                                    showName(retrievedShow: readListing.creatorShows![index], statusColor: String(describing: String(describing: readListing.creatorShows![index]["status"]!)))
//                                             ["name"]!), status: String(describing: readListing.creatorShows![index]["status"]!), date_sched: String(describing: readListing.creatorShows![index]["date_scheduled"]!), description: String(describing: readListing.creatorShows![index]["description"]!)
                                    
                                    ShowsPageButtons(retrievedShow: readListing.creatorShows![index])
                                    //                                String(describing: retrievedShows[index]["name"]!), stream_key: String(describing: retrievedShows[index]["stream_key"]!), stream_id: String(describing: retrievedShows[index]["livestream_id"]!), liveStreamID: String(describing: retrievedShows[index]["livestream_id"]!), listingID: String(describing: retrievedShows[index]["listings"]!)
                                    
                                }
                                .frame(width: 360, height: 110)
                                .border(Color.black, width: 2)
                                .background(.white)
                                .id(index)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                //            .onAppear {
                //
                //            }
            }
            .refreshable {
                readListing.getCreatorShows()
                readListing.getListingIDs()
                readListing.getListings()
            }
            .onAppear {
                readListing.getCreatorShows()
                readListing.getListingIDs()
                readListing.getListings()
            }
        }
        
    }
}

struct showName: View {
    var retrievedShow: [String: Any]!
    var statusColor: String
//    var name: String!
//    var status: String!
//    var date_sched: String!
//    var description: String!
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(ColorSelector().getShowStatusColor(status: statusColor))
                .frame(width: 60, height: 20)
                .overlay(
                    Text(String(describing: retrievedShow["status"]!)).textCase(.uppercase).font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                )

            Text(String(describing: retrievedShow["name"]!))
                .font(Font.system(size: 12))
                .fontWeight(.semibold)


            Spacer()

            Text(String(describing: retrievedShow["date_scheduled"]!)).font(Font.system(size: 12))

        }
        .padding(.horizontal,6)
        .foregroundColor(.black)
        

        
        Text(String(describing: retrievedShow["description"]!)).font(Font.system(size: 12)).frame(width: 345, height: 30).foregroundColor(.black)
    }
}


struct ShowsPage_Previews: PreviewProvider {
    static var previews: some View {
        ShowsPage()
    }
}
