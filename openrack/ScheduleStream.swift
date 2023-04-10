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
    @State var showSubmission = false
    var addStream = CreateDB()
    var isBothTextFieldsEmpty: Bool {
        return streamName.isEmpty || streamDescription.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Schedule Show").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
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
                    
                    Spacer()
                    
                    Button(action: {
                        let calendar = Calendar.current
                        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
                        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
                        let combinedComponents = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day, hour: timeComponents.hour, minute: timeComponents.minute)
                        let combinedDate = calendar.date(from: combinedComponents)
                        showSubmission.toggle()
                        addStream.addShow(name: streamName, description: streamDescription, date: combinedDate!)
                    }) {
                        HStack { Text("Submit").font(.title3) }
                    }
                    .disabled(isBothTextFieldsEmpty)
                    .frame(width: 360, height: 50)
                    .background(isBothTextFieldsEmpty ? Color.gray : Color("Primary_color"))
                    .background(Color("Primary_color"))
                    .foregroundColor(.white)
                    .border(Color.black, width: 2)
                    .padding(.vertical)
                    .navigationDestination(isPresented: $showSubmission) {
                        ShowsPage().navigationBarHidden(true)
                    }
                }
            }
        }
    }
}

struct ScheduleStream_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleStream()
    }
}
