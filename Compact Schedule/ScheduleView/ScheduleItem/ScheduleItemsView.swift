//
//  ScheduleItemsView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct ScheduleItemsView: View{
    @Binding var scheduleItems: [ScheduleItem]
    @Binding var scrollOffset: CGFloat
    @Binding var editingItem: ScheduleItem?
    @Binding var currentOperate: ScheduleView.Operates
    var body: some View{
        ZStack{
            ForEach(scheduleItems, id: \.startDate){item in
                ScheduleItemView(scheduleItem: item)
                    .onLongPressGesture(){
                        editingItem = item
                    }
            }
            if currentOperate == .EditSchedule, let editingItem = editingItem{
                EditScheduleItemView(scheduleItem: editingItem, scrollOffset: $scrollOffset)
            }
        }
    }
}
