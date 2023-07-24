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
                    .onTapGesture {  } //これをおくとonLongPressGesture付きでもスクロール可能※1
                    .onLongPressGesture(){
                        editingItem = item
                        currentOperate = .EditSchedule
                    }
            }
            if currentOperate == .EditSchedule, let editingItem = editingItem{
                EditScheduleItemView(scheduleItem: editingItem, scrollOffset: $scrollOffset)
            }
        }
    }
}

//※1: https://stackoverflow-com.translate.goog/questions/66185737/swiftui-scrollview-and-onlongpressgesture?_x_tr_sl=en&_x_tr_tl=ja&_x_tr_hl=ja&_x_tr_pto=sc
