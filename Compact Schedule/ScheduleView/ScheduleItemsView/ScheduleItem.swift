//
//  ScheduleItem.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

class ScheduleItem: Object, Identifiable{
    @Persisted private var activityId: String
    var activity: Activity{
        get{ return Activity.Get(id: activityId)! }
        set{ try! realm_.write{ activityId = newValue.id }}
    }
    @Persisted private var taskId: String
    var task: Task{
        get{ return Task.Get(id: taskId)! }
        set{ try! realm_.write{ taskId = newValue.id }}
    }
    @Persisted private var startDate_ = Date()
    var startDate: Date{ //startDateはViewModelから
        get{ return startDate_ }
        set{ try! realm_.write{ startDate_ = newValue }}
    }
    @Persisted private var endDate_ = Date()
    var endDate: Date{
        get{ return endDate_ }
        set{ try! realm_.write{ endDate_ = newValue }}
    }
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    /*Computed PropertyはRealmのオブジェクトが削除された後もアクセスされることがある。
    ↓アクセス可能かを取得する変数*/
    var isAlive: Bool{
        get{ return Activity.Get(id: activityId) != nil && Task.Get(id: taskId) != nil }
    }
    override init(){
        super.init()
    }
    init(task: Task, activity: Activity, tapHeight: CGFloat){
        super.init()
        self.activityId = activity.id
        self.taskId = task.id
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
        endDate = HeightToDate(height: height)
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
        let hoursCGFloat_UntilTime
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
    //frozen対策
    func Copy() -> ScheduleItem{
        return (realm_.object(ofType: ScheduleItem.self, forPrimaryKey: id))!
    }
}

extension ScheduleItem{
    static func Get(id: String) -> ScheduleItem?{
        return realm_.object(ofType: ScheduleItem.self, forPrimaryKey: id)
    }
    static func Add(_ scheduleItem: ScheduleItem){
        try! realm_.write{
            realm_.add(scheduleItem)
        }
    }
    static func Delete(_ scheduleItem: ScheduleItem){
        try! realm_.write{
            realm_.delete(scheduleItem)
        }
    }
}
