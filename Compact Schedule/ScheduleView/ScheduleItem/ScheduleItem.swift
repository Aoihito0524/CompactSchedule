//
//  ScheduleItem.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

class ScheduleItem: ObservableObject{
    @Published var activity: Activity
    @Published var task: Task
    @Published var startDate = Date()
    @Published var endDate = Date()
    init(task: Task, activity: Activity, tapHeight: CGFloat){
        self.activity = activity
        self.task = task
        SetStartDate(height: tapHeight)
        endDate = oneHourLater(from: startDate)
    }
    func GetTime_CGFloat(date: Date) -> [String: CGFloat]{
        let calendar = Calendar(identifier: .gregorian)
        let day = CGFloat(calendar.component(.day, from: date))
        let hour = CGFloat(calendar.component(.hour, from: date))
        let minute = CGFloat(calendar.component(.minute, from: date))
        return ["day": day, "hour": hour, "minute": minute]
    }
    func GetTopHeight() -> CGFloat{
        return DateToHeight(date: startDate)
    }
    func GetBottomHeight() -> CGFloat{
        return DateToHeight(date: endDate)
    }
    func SetStartDate(height: CGFloat){
        startDate = HeightToDate(height: height)
        if isMoreThan10Min(){return;}
        endDate = Calendar.current.date(byAdding: .minute, value: 10, to: startDate)!
    }
    func SetEndDate(height: CGFloat){
        print("endDateBefore: \(endDate)")
        endDate = HeightToDate(height: height)
        print("endDateAfter: \(endDate)")
        if isMoreThan10Min(){return;}
        startDate = Calendar.current.date(byAdding: .minute, value: -10, to: endDate)!
    }
    private func isMoreThan10Min() -> Bool{
        return endDate.timeIntervalSince(startDate) >= 10 * 60
    }
    private func oneHourLater(from: Date) -> Date{
        return Calendar.current.date(byAdding: .hour, value: 1, to: from)!
    }
    private func DateToHeight(date: Date) -> CGFloat{
        let time = GetTime_CGFloat(date: date)
        let nowTime = GetTime_CGFloat(date: Date())
        let daysDifference = time["day"]! - nowTime["day"]!
        let hoursDifference = time["hour"]! - nowTime["hour"]!
        let minutesDifference = time["minute"]! - nowTime["minute"]!
        var hoursCGFloat_UntilTime
            = daysDifference * 24.0 + hoursDifference + minutesDifference / 60.0
        let height = hoursCGFloat_UntilTime * ScheduleSize.oneHourHeight
        return height
    }
    private func HeightToDate(height: CGFloat) -> Date{
        let oneMinutesHeight = ScheduleSize.oneHourHeight / 60.0
        let minutesCGFloat_UntilTime = height / oneMinutesHeight
        let minutes_UntilTime = Int(minutesCGFloat_UntilTime)
        let now = Date()
        let date = Calendar.current.date(byAdding: .minute, value: minutes_UntilTime, to: now)!
        return date
    }
}
