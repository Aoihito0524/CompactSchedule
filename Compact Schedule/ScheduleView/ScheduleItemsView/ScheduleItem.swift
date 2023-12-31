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
    let minDuration = 10 //startとendの間隔の最小。10分
    /*Computed PropertyはRealmのオブジェクトが削除された後もアクセスされることがある。
    ↓アクセス可能かを取得する変数*/
    var isAlive: Bool{
        get{ return Activity.Get(id: activityId) != nil && Task.Get(id: taskId) != nil }
    }
    @Published var currentDate = Date()
    override init(){
        super.init()
    }
    init(task: Task, activity: Activity, tapHeight: CGFloat){
        super.init()
        self.activityId = activity.id
        self.taskId = task.id
        SetStartDate(height: tapHeight)
        endDate = Date.After(task.minutes, from: startDate)
        while true{
            if !isConflicting(){ break; }
            let backup_startDate = startDate
            let backup_endDate = endDate
            GoUpIfConflicting()
            if !isConflicting(){ break; }
            //元の座標に戻さないとループする。GoDownだけ続ければ確実に下に行く
            startDate = backup_startDate
            endDate = backup_endDate
            GoDownIfConflicting()
        }
    }
    private func GoUpIfConflicting(){
        var timeInterval: TimeInterval? //移動分
        if let conflictingItem = SelfConflicting(){
            timeInterval = conflictingItem.startDate.timeIntervalSince(self.endDate)
        }
        if let timeInterval = timeInterval{
            self.startDate += timeInterval
            self.endDate += timeInterval
        }
    }
    private func GoDownIfConflicting(){
        var timeInterval: TimeInterval? //移動分
        if let conflictingItem = SelfConflicting(){
            timeInterval = conflictingItem.endDate.timeIntervalSince(self.startDate)
        }
        if let timeInterval = timeInterval{
            self.startDate += timeInterval
            self.endDate += timeInterval
        }
    }
    //描画する位置を取得
    func GetTopHeight() -> CGFloat{
        return DateToHeight(date: startDate)
    }
    func GetBottomHeight() -> CGFloat{
        return DateToHeight(date: endDate)
    }
    //予定を移動
    func SetStartDate(height: CGFloat){
        SetStartDate(date: HeightToDate(height: height))
    }
    func SetEndDate(height: CGFloat){
        SetEndDate(date: HeightToDate(height: height))
    }
    func SetStartDate(date: Date){
        startDate = date
        if isMoreThanMinDuration(){return;}
        endDate = Calendar.current.date(byAdding: .minute, value: minDuration, to: startDate)!
    }
    func SetEndDate(date: Date){
        endDate = date
        if isMoreThanMinDuration(){return;}
        startDate = Calendar.current.date(byAdding: .minute, value: -minDuration, to: endDate)!
    }
    private func isMoreThanMinDuration() -> Bool{
        let seconds_1min = 60
        let seconds_MinDuration = minDuration * seconds_1min
        return endDate.timeIntervalSince(startDate) >= CGFloat(seconds_MinDuration)
    }
    //位置と時間の対応づけ
    private func DateToHeight(date: Date) -> CGFloat{
        let hours_inADay = 24.0
        let hours_inAMinutes = 1/60.0
        let DHM = DayHourMinute(date: date)
        let nowDHM = DayHourMinute(date: currentDate)
        let DHM_difference = DHM - nowDHM
        //DHMを時間(hours)で表す
        var hoursCGFloat_UntilTime = DHM_difference.dayCGFloat * hours_inADay       //日付を加算
        hoursCGFloat_UntilTime += DHM_difference.hourCGFloat                        //時間を加算
        hoursCGFloat_UntilTime += DHM_difference.minuteCGFloat * hours_inAMinutes   //分を加算
        let height = hoursCGFloat_UntilTime * ScheduleSize.oneHourHeight
        return height
    }
    private func HeightToDate(height: CGFloat) -> Date{
        let minutes_inAnHour = 60
        let oneMinutesHeight = ScheduleSize.oneHourHeight / CGFloat(minutes_inAnHour)
        let minutesCGFloat_UntilTime = height / oneMinutesHeight
        let minutes_UntilTime = Int(minutesCGFloat_UntilTime)
        let date = Calendar.current.date(byAdding: .minute, value: minutes_UntilTime, to: currentDate)!
        return date
    }
}

//予定を移動させた際に重ならないように判定
extension ScheduleItem{
//重なっている相手を特定
    func SelfTopConflicting() -> ScheduleItem?{
        let scheduleItems = realm_.objects(ScheduleItem.self)
        for scheduleItem in scheduleItems{
            if scheduleItem.id == self.id { continue; }
            if SelfTopIsConflictingWith(scheduleItem){ return scheduleItem;}
        }
        return nil;
    }
    func SelfBottomConflicting() -> ScheduleItem?{
        let scheduleItems = realm_.objects(ScheduleItem.self)
        for scheduleItem in scheduleItems{
            if scheduleItem.id == self.id { continue; }
            if SelfBottomIsConflictingWith(scheduleItem){ return scheduleItem;}
        }
        return nil;
    }
    func SelfConflicting() -> ScheduleItem?{
        let scheduleItems = realm_.objects(ScheduleItem.self)
        for scheduleItem in scheduleItems{
            if scheduleItem.id == self.id { continue; }
            if isConflictingWith(scheduleItem){ return scheduleItem;}
        }
        return nil;
    }
    func SelfCovering() -> ScheduleItem?{
        let scheduleItems = realm_.objects(ScheduleItem.self)
        for scheduleItem in scheduleItems{
            if scheduleItem.id == self.id { continue; }
            if isCovering(scheduleItem){ return scheduleItem;}
        }
        return nil;
    }
//重なっているものがあるかを確認
    func isConflicting() -> Bool{
        let scheduleItems = realm_.objects(ScheduleItem.self)
        for scheduleItem in scheduleItems{
            if scheduleItem.id == self.id { continue; }
            if isConflictingWith(scheduleItem){ return true; }
        }
        return false
    }
//特定の相手と重なっているか確認
    private func isConflictingWith(_ scheduleItem: ScheduleItem) -> Bool{
        if SelfTopIsConflictingWith(scheduleItem){ return true;}
        if SelfBottomIsConflictingWith(scheduleItem){ return true;}
        if isCovering(scheduleItem){ return true;}
        return false
    }
    private func isCovering(_ scheduleItem: ScheduleItem) -> Bool{
        return startDate < scheduleItem.startDate && scheduleItem.endDate < endDate
    }
    private func SelfTopIsConflictingWith(_ scheduleItem: ScheduleItem) -> Bool{
        if self.startDate <= scheduleItem.startDate{ return false}//startDateが範囲内
        if self.startDate >= scheduleItem.endDate{ return false}  //にある時通過
        return true
    }
    private func SelfBottomIsConflictingWith(_ scheduleItem: ScheduleItem) -> Bool{
        if self.endDate <= scheduleItem.startDate{ return false}//endDateが範囲内
        if self.endDate >= scheduleItem.endDate{ return false}  //にある時通過
        return true
    }
}

//static関数
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
    static func DeletePastItems(){
        let items = realm_.objects(ScheduleItem.self)
        let now = Date()
        try! realm_.write{
            for item in items{
                if item.endDate < now{
                    realm_.delete(item)
                }
            }
        }
    }
}

extension Date{
    //単位=分に注意
    static func After(_ minutes: Int, from: Date) -> Date{
        return Calendar.current.date(byAdding: .minute, value: minutes, to: from)!
    }
    static func Before(_ minutes: Int, from: Date) -> Date{
        return Calendar.current.date(byAdding: .minute, value: -minutes, to: from)!
    }
}

