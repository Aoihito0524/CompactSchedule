//
//  EditScheduleItemView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct ScheduleItem_EditView: View{
    @ObservedRealmObject var editingItem: ScheduleItem
    @Binding var currentOperate: ScheduleViewModel.Operates
    @Binding var scrollOffset: CGFloat
    @ObservedObject var VM: ScheduleItem_EditViewModel
    let horizontalPadding = DEVICE_WIDTH * 0.07
    init(editingItem: ScheduleItem, currentOperate: Binding<ScheduleViewModel.Operates>, scrollOffset: Binding<CGFloat>){
        self.editingItem = editingItem
        self._scrollOffset = scrollOffset
        self._currentOperate = currentOperate
        VM = ScheduleItem_EditViewModel(scheduleItem: editingItem.thaw()!)
    }
    var body: some View{
        ScheduleItemView(scheduleItem: editingItem){ width, height, cornerRadius, color in
            EditScheduleItemBackground(width: width, height: height, cornerRadius: cornerRadius, color: color)
        }
        //削除ボタン
        .overlay(alignment: .topTrailing){
            Button(action: {
                currentOperate = .Default
                ScheduleItem.Delete(editingItem.thaw()!)
            }){
                Image(systemName: "trash")
            }
        }
        .setScrollTop()
        .padding(.top, editingItem.GetTopHeight())
        .padding(.horizontal, horizontalPadding)
        //ドラッグで予定を編集
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

extension View{
    func strokeRoundedRectangle(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
            self.padding(width)
        }
    }
}
