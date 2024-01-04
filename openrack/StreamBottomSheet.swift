//
//  StreamBottomSheet.swift
//  openrack
//
//  Created by Ayman Ali on 06/04/2023.
//
import SwiftUI

struct StreamBottomSheet: View {
    @Binding var showingBottomSheet: Bool
    @Binding var isShowingNextView: Bool
    var body: some View {
        GeometryReader { geometry in
            var btnWidth = geometry.size.width - 40
            ZStack{
                Color("Primary_color").ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Add").font(.title2)
                        Spacer()
                        Button(action: { showingBottomSheet.toggle() }) { Image(systemName: "xmark").font(.system(size: 20)) }
                    }
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30)
                    .fontWeight(.semibold)
                    
                    Divider().frame(width: geometry.size.width, height: 2).background(.white).padding(.top, 5).padding(.bottom, 15).opacity(0.5)
                    
                    Button(action: {
                        showingBottomSheet.toggle()
                        isShowingNextView.toggle() }) {
                            HStack {
                                Image(systemName: "play.fill").font(.system(size: 20)).padding(.trailing, 5)
                                Text("Schedule a Show").font(.title2)
                            }
                            .fontWeight(.medium)
                        }
                        .frame(width: btnWidth, height: 60)
                        .background(.white).foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 2))
                        .cornerRadius(50)
                        .padding()
                }
            }
        }
    }
}
