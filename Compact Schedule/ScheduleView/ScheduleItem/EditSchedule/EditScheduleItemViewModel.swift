//
//  EditScheduleItemViewModel.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/21.
//

import SwiftUI

class EditScheduleItemViewModel: ObservableObject{
    let scheduleItem: ScheduleItem
    let dragObserver: ScheduleDragObserver //予定のStart/Endの変更はドラッグで行い、それを管理するための変数
    @Published var isDragStart = true
    init(scheduleItem: ScheduleItem){
        self.scheduleItem = scheduleItem
        self.dragObserver = ScheduleDragObserver(scheduleItem: scheduleItem)
    }
    func SetEdge(location: CGPoint){
        switch dragObserver.dragPosition{
        case .top:
            scheduleItem.SetStartDate(height: location.y)
        case .bottom:
            scheduleItem.SetEndDate(height: location.y)
        case .body:
            scheduleItem.SetStartDate(height: location.y - dragObserver.firstTapDistanceFromTop)
            scheduleItem.SetEndDate(height: location.y + dragObserver.firstTapDistanceFromBottom)
        }
    }
    func SetDragInfo_atStart(point: CGPoint, scrollOffset: CGFloat){
        dragObserver.SetDragInfo_atStart(point: point, scrollOffset: scrollOffset)
    }
}
