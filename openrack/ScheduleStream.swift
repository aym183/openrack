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
    @State var isLoading = false
    var addStream = CreateDB()
    var isBothTextFieldsEmpty: Bool {
        return streamName.isEmpty || streamDescription.isEmpty
    }
    
    var body: some View {
        GeometryReader { geometry in
            var btnWidth = geometry.size.width - 40
            NavigationStack {
                ZStack {
                    Color("Secondary_color").ignoresSafeArea()
                    
                    if isLoading {
                        VStack {
                            ProgressView()
                                .scaleEffect(1.75)
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            
                            Text("Creating your show 😁").fontWeight(.semibold).multilineTextAlignment(.center).padding(.top, 30).padding(.horizontal).foregroundColor(.black)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Schedule Show").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                        
                        Text("Show Name").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $streamName)
                            .padding(.horizontal, 8)
                            .frame(width: btnWidth, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        Text("Show Description").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2)
                        
                        TextField("", text: $streamDescription)
                            .padding(.horizontal, 8)
                            .frame(width: btnWidth, height: 50).border(Color.black, width: 2)
                            .background(.white)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Date").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2).padding(.leading, -9)
                                DatePicker(selection: $selectedDate, displayedComponents: .date){ EmptyView() }
                                    .labelsHidden()
                                    .frame(width: 100)
                            }
                            .padding(.leading, 10)
                            
                            VStack(alignment: .leading) {
                                Text("Time").font(Font.system(size: 15)).fontWeight(.heavy).padding(.top, 10).padding(.bottom, -2).padding(.leading, 7)
                                DatePicker(selection: $selectedTime, displayedComponents: .hourAndMinute){ EmptyView() }
                                    .labelsHidden()
                                    .frame(width:85)
                            }
                            .padding(.leading, 30)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            CreateDB().createLiveStream { response in
                                switch response {
                                case .success(let array):
                                    addStream.addShow(name: streamName, description: streamDescription, date: MiscData().convertDateToString(date_value: selectedDate, time_value: selectedTime), livestream_id: array[0], playback_id: array[1], stream_key: array[2])
                                    
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                            isLoading.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    showSubmission.toggle()
                                }
                            }
                        }) {
                            HStack { Text("Submit").font(.title3) }
                        }
                        .disabled(isBothTextFieldsEmpty)
                        .frame(width: btnWidth, height: 50)
                        .background(isBothTextFieldsEmpty ? Color.gray : Color("Primary_color"))
                        .foregroundColor(.white)
                        .border(Color.black, width: 2)
                        .padding(.vertical)
                        .navigationDestination(isPresented: $showSubmission) {
                            BottomNavbar(isShownFeed: false).navigationBarBackButtonHidden(true)
                        }
                    }
                    .opacity(isLoading ? 0 : 1)
                }
                .foregroundColor(.black)
            }
        }
        
    }
}

struct ScheduleStream_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleStream()
    }
}
