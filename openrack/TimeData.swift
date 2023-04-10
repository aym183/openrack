//
//  TimeData.swift
//  openrack
//d
//  Created by Ayman Ali on 09/04/2023.
//

import Foundation


class TimeData : ObservableObject {
    func getPresentDateTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func convertDateToString(date_value: Date, time_value: Date) -> String {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date_value)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time_value)
        let combinedComponents = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day, hour: timeComponents.hour, minute: timeComponents.minute)
        let combinedDate = calendar.date(from: combinedComponents)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateString = dateFormatter.string(from: combinedDate!)
        return formattedDateString // Output: 2023-04-17 20:03:00
    }
    
    func getRandomID() -> Int {
        return Int.random(in: 1000000...999999999)
    }
}
