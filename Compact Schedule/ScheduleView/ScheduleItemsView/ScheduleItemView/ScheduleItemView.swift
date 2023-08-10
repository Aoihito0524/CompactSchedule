//
//  ScheduleItemView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift
        
struct ScheduleItemView<T: View>: View{
    @ObservedRealmObject var scheduleItem: ScheduleItem
    @ViewBuilder var backgroundContent: (CGFloat, CGFloat, CGFloat, Color) -> T
    let width = DEVICE_WIDTH * 0.6
    let paddingWidth = DEVICE_WIDTH * 0.05
    var height: CGFloat{
        get{ return scheduleItem.GetBottomHeight() - scheduleItem.GetTopHeight(); }
    }
    let VM: ScheduleItemViewModel
    let cornerRadius = ScheduleItemViewSize.cornerRadius
    let thresholdHeight_LayoutChange = DEVICE_HEIGHT * 0.08
    init(scheduleItem: ScheduleItem, backgroundContent: @escaping (CGFloat, CGFloat, CGFloat, Color) -> T) {
        self.scheduleItem = scheduleItem
        self.backgroundContent = backgroundContent
        self.VM = ScheduleItemViewModel(scheduleItem: scheduleItem)
    }
    var body: some View{
        if scheduleItem.isAlive{
            ZStack(alignment: .leading){
                //予定の背景部分
                backgroundContent(width, height, cornerRadius, scheduleItem.activity.color)
                //予定の文字部分
                ZStack{
                    if VM.GetFrameHeight() < thresholdHeight_LayoutChange{
                        TagAndTaskView_HorizontalLayout(scheduleItem: scheduleItem)
                    }
                    else{
                        TagAndTaskView_VerticalLayout(scheduleItem: scheduleItem)
                    }
                }
                .frame(width: width, height: VM.GetFrameHeight())
            }
        }
        else{
            EmptyView()
        }
    }
}

class ScheduleItemViewModel: ObservableObject{
    @Published var scheduleItem: ScheduleItem
    init(scheduleItem: ScheduleItem) {
        self.scheduleItem = scheduleItem
    }
    func GetFrameHeight() -> CGFloat{
        return scheduleItem.GetBottomHeight() - scheduleItem.GetTopHeight()
    }
}

