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
    @State var streamStarted = false
    var retrievedShows = UserDefaults.standard.array(forKey: "shows") as? [[String: Any]]
    
    
    var body: some View {
        var noOfShows = retrievedShows?.count ?? 0
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack (alignment: .leading) {

                Text("Shows").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20)
                Spacer()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        // Change to length of response array
//                        noOfShows
                        ForEach(0..<noOfShows) { index in
                            VStack {
                                HStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Primary_color"))
                                        .frame(width: 60, height: 20)
                                        .overlay(
                                            Text("CREATED").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                                        )

                                    Text(String(describing:retrievedShows![index]["name"]!))
                                        .font(Font.system(size: 12))
                                        .fontWeight(.semibold)


                                    Spacer()

                                    Text(String(describing:retrievedShows![index]["date_scheduled"]!)).font(Font.system(size: 12))

                                }
                                .padding(.horizontal,6)
                                

                                Text(String(describing:retrievedShows![index]["description"]!)).font(Font.system(size: 12)).frame(width: 345, height: 30)

                                HStack {
                                    Button(action: { streamStarted.toggle() }) {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.black)
                                            .frame(width: 95, height: 30)
                                            .overlay(
                                                Text("Start Streaming").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                                            )
                                    }
                                    .navigationDestination(isPresented: $streamStarted) {
                                        CreatorShow().navigationBarHidden(true)
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

struct ShowsPage_Previews: PreviewProvider {
    static var previews: some View {
        ShowsPage()
    }
}
