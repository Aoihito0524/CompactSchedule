//
//  ScheduleViewModel.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI

class ScheduleViewModel: ObservableObject{
    @Published var editingItem: ScheduleItem?
    @Published var tapLocation = CGPoint.zero
    @Published var scrollOffset: CGFloat = 0.0
    @Published var currentOperate = Operates.Default
    enum Operates{
        case Default
        case AddPopup
        case selectNewPopup
        case EditSchedule
    }
    func TapPosition() -> CGPoint{
        return CGPoint(x: tapLocation.x, y: tapLocation.y - scrollOffset)
    }
    func onBackgroundTapped(tapLocation: CGPoint){
        print("スケジュールがタップされました")
        self.tapLocation = tapLocation
        toggle_AddPopupOrNot() //追加ボタンの表示/非表示切り替え
    }
    private func toggle_AddPopupOrNot(){
        if currentOperate == .Default{
            currentOperate = .AddPopup
        }
        else{
            currentOperate = .Default
        }
    }
}
