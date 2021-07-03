//
//  DateUtils.swift
//  Get it Done
//
//  Created by Satish Bandaru on 03/07/21.
//

import Foundation

struct DateUtils {
    static func dayIdentifier(date: Date, includeTime: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = includeTime ? "h:mm a" : ""
            return "Today \(dateFormatter.string(from: date))"
        } else if Calendar.current.isDateInTomorrow(date) {
            dateFormatter.dateFormat = includeTime ? "h:mm a" : ""
            return "Tomorrow \(dateFormatter.string(from: date))"
        }
        
        dateFormatter.dateFormat = includeTime ? "d MMMM yyyy h:mm a" : "d MMMM yyyy"
        return dateFormatter.string(from: date)
    }
}
