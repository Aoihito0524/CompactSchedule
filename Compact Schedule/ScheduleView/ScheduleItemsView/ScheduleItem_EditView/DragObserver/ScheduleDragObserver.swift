//
//  DragObserver.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/21.
//

import SwiftUI

class ScheduleDragObserver{
    let scheduleItem: ScheduleItem //TopHeightとBottomHeight取得用
    var dragPosition = DragPosition.body //どこを引っ張っているかを表す
    let maxTapDistance = 30.0 //端からこの距離内にある時に端をタップしたとみなす距離
    //最初にタップした点と端の距離
    var firstTapDistanceFromTop: CGFloat = 0
    var firstTapDistanceFromBottom: CGFloat = 0
    enum DragPosition{
        case body
        case top
        case bottom
    }
    init(scheduleItem: ScheduleItem){
        self.scheduleItem = scheduleItem
    }
    
    func SetDragInfo_atStart(point: CGPoint, scrollOffset: CGFloat){
        SetFirstTapDistances(point: point, scrollOffset: scrollOffset)
        SetDragPosition()
    }
    private func SetDragPosition(){
        if IsTopEdge(){
            dragPosition = DragPosition.top
        }
        else if IsBottomEdge(){
            dragPosition = DragPosition.bottom
        }
        else{
            dragPosition = DragPosition.body
        }
    }
    private func SetFirstTapDistances(point: CGPoint, scrollOffset: CGFloat){
        let topHeight = scheduleItem.GetTopHeight()
        let bottomHeight = scheduleItem.GetBottomHeight()
        firstTapDistanceFromTop = abs(topHeight - (point.y - scrollOffset))
        firstTapDistanceFromBottom = abs(bottomHeight - (point.y - scrollOffset))
    }
    private func IsTopEdge() -> Bool{
        return firstTapDistanceFromTop < maxTapDistance
    }
    private func IsBottomEdge() -> Bool{
        return firstTapDistanceFromBottom < maxTapDistance
    }
}
