//
//  ScheduleStream.swift
//  openrack
//
//  Created by Ayman Ali on 06/04/2023.
//

import SwiftUI

struct ScheduleStream: View {
    @State var streamName = ""
    @State var streamDescription = ""
    @State var selectedDate = Date()
    @State var selectedTime = Date()
    
    var body: some View {
        ZStack {
            Color("Secondary_color").ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Schedule Show").font(Font.system(size: 30)).fontWeight(.bold)
                
                Text("Show Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                
                TextField("", text: $streamName)
                    .padding(.horizontal, 8)
                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                    .background(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Text("Show Description").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                
                TextField("", text: $streamDescription)
                    .padding(.horizontal, 8)
                    .frame(width: 360, height: 50).border(Color.black, width: 2)
                    .background(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Date").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        DatePicker(selection: $selectedDate, displayedComponents: .date){ EmptyView() }
                            .labelsHidden()
                            .frame(width: 100)
                    }
                    .padding(.leading, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Time").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute){ EmptyView() }
                            .labelsHidden()
                            .frame(width:85)
                    }
                    .padding(.leading, 30)
                }
                
                
//                .frame(width: 360, height: 100)
                
                
//                DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
            }
        }
    }
}

struct ScheduleStream_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleStream()
    }
}
