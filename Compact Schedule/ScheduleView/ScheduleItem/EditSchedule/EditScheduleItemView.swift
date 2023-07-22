//
//  EditScheduleItemView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct EditScheduleItemView: View{
    @ObservedObject var scheduleItem: ScheduleItem
    @Binding var scrollOffset: CGFloat
    @ObservedObject var VM: EditScheduleItemViewModel
    init(scheduleItem: ScheduleItem, scrollOffset: Binding<CGFloat>){
        self.scheduleItem = scheduleItem
        self._scrollOffset = scrollOffset
        VM = EditScheduleItemViewModel(scheduleItem: scheduleItem)
    }
    var body: some View{
        ScheduleItemView(scheduleItem: scheduleItem, strokeBorder: true)
            .gesture(DragGesture(minimumDistance: 0.0)
                .onChanged{value in
                    let location = value.location
                    if VM.isDragStart{
                        VM.SetDragInfo_atStart(point: location, scrollOffset: scrollOffset)
                        VM.isDragStart = false
                    }
                    VM.SetEdge(location: location)
                }
                .onEnded{_ in
                    VM.isDragStart = true
                })
    }
}
