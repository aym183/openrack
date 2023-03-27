//
//  ContentView.swift
//  openrack
//
//  Created by Ayman Ali on 26/03/2023.
//

import SwiftUI

struct ContentView: View {
    // Addef test comment
    var body: some View {
        VStack {
            HStack {
                
                Image(systemName: "person.circle.fill")
                    .foregroundColor(.black)
                    .onTapGesture {
                        print("Hi")
                    }
                
//                    .font(.sytem(size: ))
            }
//            .frame(height: 50, width: )
            .padding()
            .background(.thinMaterial)
            .cornerRadius(10)
            
            Spacer()
            RoundedRectangle(cornerRadius: 50)
                .frame(height: 60)
                
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
