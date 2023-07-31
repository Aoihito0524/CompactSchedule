//
//  ScheduleItem_NormalView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/31.
//

import SwiftUI

struct ScheduleItem_DisplayView: View{
    let scheduleItem: ScheduleItem
    @Binding var editingItem: ScheduleItem?
    @Binding var currentOperate: ScheduleView.Operates
    var body: some View{
            ScheduleItemView(scheduleItem: scheduleItem){ width, height, cornerRadius, color in
                ScheduleItemBackground(width: width, height: height, cornerRadius: cornerRadius, color: color)
            }
            .onTapGesture {  } //これをおくとonLongPressGesture付きでもスクロール可能※1
            .onLongPressGesture(){
                editingItem = scheduleItem
                currentOperate = .EditSchedule
            }
            .padding(.top, scheduleItem.GetTopHeight())
            .setScrollTop()
    }
}
