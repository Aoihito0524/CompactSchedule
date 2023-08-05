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
        scheduleItem.SetStartDate(height: location.y)
        StopIfConflicting()
    }
    //下端を動かす
    private func SetBottomEdge(location: CGPoint){
        scheduleItem.SetEndDate(height: location.y)
        StopIfConflicting()
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
        let backup_StartDate = scheduleItem.startDate
        let backup_EndDate = scheduleItem.endDate
        let duration = backup_EndDate.timeIntervalSince(backup_StartDate)
        scheduleItem.SetStartDate(height: location.y - dragObserver.firstTapDistanceFromTop)
        scheduleItem.SetEndDate(height: location.y + dragObserver.firstTapDistanceFromBottom)
        //最初に衝突した時
        if !conflicting{
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
        }
    //conclicting = trueの時
        //重なっている時
        if scheduleItem.isConflicting(){
            scheduleItem.startDate = backup_StartDate
            scheduleItem.endDate = backup_EndDate
        }
        //重なりが終わった時
        else{ conflicting = false }
    }
}

