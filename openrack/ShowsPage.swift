//
//  ShowsPage.swift
//  openrack
//
//  Created by Ayman Ali on 07/04/2023.
//
import SwiftUI
import Foundation

struct ShowsPage: View {
    var columns: [GridItem] = [GridItem(.flexible() , spacing: nil, alignment: nil)]
    @StateObject var readListing = ReadDB()
    var allListingIDs: [String] = []
    
    var body: some View {
        GeometryReader { geometry in
            var varWidth = geometry.size.width - 30
            var noOfShows = readListing.creatorShows!.count ?? 0
            NavigationStack {
                ZStack {
                    Color("Secondary_color").ignoresSafeArea()
                    VStack (alignment: .leading) {
                        Text("Shows").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20).foregroundColor(.black)
                        Spacer()
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(0..<noOfShows, id: \.self) { index in
                                    VStack {
                                        showName(retrievedShow: readListing.creatorShows![index], statusColor: String(describing: String(describing: readListing.creatorShows![index]["status"]!)))
                                        ShowsPageButtons(retrievedShow: readListing.creatorShows![index])
                                    }
                                    .frame(width: varWidth, height: 110)
                                    .border(Color.black, width: 2)
                                    .background(.white)
                                    .id(index)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
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
}

struct showName: View {
    var retrievedShow: [String: Any]!
    var statusColor: String
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
        .padding(.horizontal,6).padding(.top, 5)
        .foregroundColor(.black)
        
        Text(String(describing: retrievedShow["description"]!)).font(Font.system(size: 12)).frame(width: 345, height: 30).foregroundColor(.black)
    }
}
