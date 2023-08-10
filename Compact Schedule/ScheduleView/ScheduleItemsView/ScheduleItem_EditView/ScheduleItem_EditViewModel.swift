//
//  EditScheduleItemViewModel.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/21.
//

import SwiftUI

class ScheduleItem_EditViewModel: ObservableObject{
    let scheduleItem: ScheduleItem
    let dragObserver: ScheduleDragObserver
    //予定のStart/Endの変更はドラッグで行い、それを管理するための変数
    @Published var isDragStart = true
    init(scheduleItem: ScheduleItem){
        self.scheduleItem = scheduleItem
        self.dragObserver = ScheduleDragObserver(scheduleItem: scheduleItem)
    }
    func SetEdge(location: CGPoint){
        switch dragObserver.dragPosition{
        case .top:
            SetTopEdge(location: location)
        case .bottom:
            SetBottomEdge(location: location)
        case .body:
            SetBodyPosition(location: location)
        }
    }
    func SetDragInfo_atStart(point: CGPoint, scrollOffset: CGFloat){
        dragObserver.SetDragInfo_atStart(point: point, scrollOffset: scrollOffset)
    }
    //上端を動かす
    private func SetTopEdge(location: CGPoint){
        RestoreDates(when: {return scheduleItem.SelfCovering() != nil}){
            //以下の処理後、他の予定を覆う場合は復元する
            scheduleItem.SetStartDate(height: location.y)
            StopIfConflicting()
        }
    }
    //下端を動かす
    private func SetBottomEdge(location: CGPoint){
        RestoreDates(when: {return scheduleItem.SelfCovering() != nil}){
            //以下の処理後、他の予定を覆う場合は復元する
            scheduleItem.SetEndDate(height: location.y)
            StopIfConflicting()
        }
    }
    private func StopIfConflicting(){
        //上端が下端に当たったとき下端座標でストップする
        if let conflictingItem = scheduleItem.SelfTopConflicting(){
            scheduleItem.SetStartDate(date: conflictingItem.endDate)
        }
        //下端が上端に当たったとき下端座標でストップする
        if let conflictingItem = scheduleItem.SelfBottomConflicting(){
            scheduleItem.SetEndDate(date: conflictingItem.startDate)
        }
    }
    @Published var conflicting = false //最初の衝突を判定するために使う
    //全体を移動させる
    private func SetBodyPosition(location: CGPoint){
        let SetDates = {
            self.scheduleItem.SetStartDate(height: location.y - self.dragObserver.firstTapDistanceFromTop)
            self.scheduleItem.SetEndDate(height: location.y + self.dragObserver.firstTapDistanceFromBottom)
        }
        let duration = scheduleItem.endDate.timeIntervalSince(scheduleItem.startDate)
        //最初に衝突した時
        if !conflicting{
            SetDates()
            //上端が衝突した場合
            if let conflictingItem = scheduleItem.SelfTopConflicting(){
                conflicting = true
                scheduleItem.startDate = conflictingItem.endDate
                scheduleItem.endDate = scheduleItem.startDate + duration
                return;
            }
            //下端が衝突した場合
            if let conflictingItem = scheduleItem.SelfBottomConflicting(){
                conflicting = true
                scheduleItem.endDate = conflictingItem.startDate
                scheduleItem.startDate = scheduleItem.endDate - duration
                return;
            }
            return;
        }
    //conclicting = trueの時(最初の衝突の後、衝突中)
        RestoreDates(when: scheduleItem.isConflicting){
            SetDates()
            //衝突終了判定
            if !scheduleItem.isConflicting(){
                conflicting = false
            }
        }
    }
    private func RestoreDates(when: () -> Bool, function : () -> ()){
        let backup_StartDate = scheduleItem.startDate
        let backup_EndDate = scheduleItem.endDate
        function()
        if when(){
            scheduleItem.startDate = backup_StartDate
            scheduleItem.endDate = backup_EndDate
        }
    }
}

