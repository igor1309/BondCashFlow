//
//  Date+Extensions.swift
//
//  Created by Igor Malyarov on 23.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

public extension Date {
    
    var isWeekend: Bool {
        // MARK:- ДОДЕЛАТЬ!!
        return false
    }
    
    
    var nextWeekStartRU: Date {
        return self.firstDayOfWeekRU.addWeeks(1)
    }
    
    //    https://spin.atomicobject.com/2017/07/28/swift-extending-date/
    var firstDayOfWeekRU: Date {
        var beginningOfWeek = Date()
        var interval = TimeInterval()
        
        //  в оригинале
        //  _ = Calendar.current.dateInterval(of: .weekOfYear, start: &beginningOfWeek, interval: &interval, for: self)
        //  return beginningOfWeek
        //  поэтому возвращается воскресенье, а мне нужен понедельник
        //  для этого два сдвига:
        _ = Calendar.current.dateInterval(of: .weekOfYear, start: &beginningOfWeek, interval: &interval, for: self.addDays(-1))
        return beginningOfWeek.addDays(1)
    }
    
    func addDays(_ numDays: Int) -> Date {
        var components = DateComponents()
        components.day = numDays
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    func addWeeks(_ numWeeks: Int) -> Date {
        var components = DateComponents()
        components.weekOfYear = numWeeks
        
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        let cal = Calendar.current
        var components = DateComponents()
        components.day = 1
        return cal.date(byAdding: components, to: self.startOfDay)!.addingTimeInterval(-1)
    }
    func daysBetween(_ date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self.startOfDay, to: date.startOfDay)
        
        return components.day!
    }
    
    // https://gist.github.com/kunikullaya/6474fc6537ed616b1c617646d263555d
    func toString(format: String = "dd.MM.yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
