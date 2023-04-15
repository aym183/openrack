//
//  CreateListings.swift
//  openrack
//
//  Created by Ayman Ali on 15/04/2023.
//

import SwiftUI

struct CreateListings: View {
    @State var streamName = ""
    @State var streamDescription = ""
    @State var selectedDate = Date()
    @State var selectedTime = Date()
    @State var showSubmission = false
    @State var showingBottomSheet = false
    @State var isLoading = false
    var addStream = CreateDB()
    var isBothTextFieldsEmpty: Bool {
        return streamName.isEmpty || streamDescription.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Secondary_color").ignoresSafeArea()
                
                if isLoading {
                    VStack {
                        ProgressView()
                            .scaleEffect(2.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        
                        Text("Hold on while we create your show 😁").fontWeight(.semibold).multilineTextAlignment(.center).padding(.top, 30).padding(.horizontal).foregroundColor(.black)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Listings").font(Font.system(size: 30)).fontWeight(.bold).padding(.top, 20)
                    
                    ScrollView() {
                        Text("Hello")
                    }
                    
                    Spacer()
                    
                    HStack{
                        Button(action: { showingBottomSheet.toggle() }, label: {
                                Text("+")
                                    .font(.system(.largeTitle)).frame(width: 50, height: 40)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 7)
                            })
                            .background(Color("Primary_color"))
                            .cornerRadius(38.5)
                            .padding(.bottom, -15)
                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                    .frame(width: 360, height: 50)
                    .sheet(isPresented: $showingBottomSheet) {
                        ListingsForm(showingBottomSheet: $showingBottomSheet)
                            .presentationDetents([.height(750)])
                    }
                    
                    Button(action: {
                        CreateDB().createLiveStream { response in
                            switch response {
                                case .success(let array):
                                    addStream.addShow(name: streamName, description: streamDescription, date: TimeData().convertDateToString(date_value: selectedDate, time_value: selectedTime), livestream_id: array[0], playback_id: array[1], stream_key: array[2])
                                    
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                            }
                        }
                        isLoading.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showSubmission.toggle()
                        }
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
                        BottomNavbar().navigationBarHidden(true)
                    }
                }
                .opacity(isLoading ? 0 : 1)
            }
            .foregroundColor(.black)
        }
    }
}

struct CreateListings_Previews: PreviewProvider {
    static var previews: some View {
        CreateListings()
    }
}
