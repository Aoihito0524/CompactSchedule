//
//  DayHourMinute.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI

struct DayHourMinute{
    let day: Int
    let hour: Int
    let minute: Int
    var dayCGFloat: CGFloat{ get{ return CGFloat(day)} }
    var hourCGFloat: CGFloat{ get{ return CGFloat(hour)} }
    var minuteCGFloat: CGFloat{ get{ return CGFloat(minute)} }
    init(date: Date){
        let calendar = Calendar(identifier: .gregorian)
        day = calendar.component(.day, from: date)
        hour = calendar.component(.hour, from: date)
        minute = calendar.component(.minute, from: date)
    }
    init(day: Int, hour: Int, minute: Int){
        self.day = day
        self.hour = hour
        self.minute = minute
    }
    static func -(lhs: DayHourMinute, rhs: DayHourMinute) -> DayHourMinute{
        let day_difference = lhs.day - rhs.day
        let hour_difference = lhs.hour - rhs.hour
        let minute_difference = lhs.minute - rhs.minute
        return DayHourMinute(day: day_difference, hour: hour_difference, minute: minute_difference)
    }
}
