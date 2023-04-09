//
//  ShowsPage.swift
//  openrack
//
//  Created by Ayman Ali on 07/04/2023.
//
import SwiftUI

struct ShowsPage: View {
    var columns: [GridItem] = [
        GridItem(.flexible() , spacing: nil, alignment: nil)
    ]
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack (alignment: .leading) {
                Text("Shows").font(Font.system(size: 30)).fontWeight(.bold).padding(.vertical, 20)
                Spacer()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        // Change to length of response array
                        ForEach(0..<6) { index in
                            VStack {
                                HStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Primary_color"))
                                        .frame(width: 60, height: 20)
                                        .overlay(
                                            Text("CREATED").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                                        )

                                    Text("Title")
                                        .font(Font.system(size: 12))
                                        .fontWeight(.semibold)

                                    Button(action: {}) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .frame(width: 80, height: 20)
                                            .overlay(
                                                Text("Cancel Stream").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.red)
                                            )
                                            .background(
                                                RoundedRectangle(cornerRadius: 11)
                                                    .fill(.black)
                                                    .frame(width: 81.5, height: 22)
                                            )
                                    }

                                    Spacer()

                                    Text("07/09/2022 12:00 PM").font(Font.system(size: 12))

                                }
                                .padding(.top,6).padding(.horizontal,6)
                                Spacer ()

                                HStack {
                                    Button(action: {}) {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.black)
                                            .frame(width: 95, height: 30)
                                            .overlay(
                                                Text("Start Streaming").font(Font.system(size: 10)).fontWeight(.semibold).foregroundColor(.white)
                                            )
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
                                    
                                    Spacer()
                                }
                                .padding(.bottom,6).padding(.horizontal,6)

                            }
                            .frame(width: 360, height: 80)
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
