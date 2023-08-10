//
//  ScheduleItemsView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct ScheduleItemsView: View{
    @ObservedResults(ScheduleItem.self) var scheduleItems
    @Binding var editingItem: ScheduleItem?
    @Binding var currentOperate: ScheduleViewModel.Operates
    @ObservedObject var realtimeDate = RealtimeDate.shared
    var body: some View{
        ZStack{
            ForEach(scheduleItems, id: \.startDate){item in
                if currentOperate == .EditSchedule, let edit = editingItem, item.id == edit.id{}//操作中のやつはまた別に表示するため非表示
                else{
                    ScheduleItem_DisplayView(scheduleItem: item, editingItem: $editingItem, currentOperate: $currentOperate)
                }
            }
        }
        .onAppear{
            ScheduleItem.DeletePastItems()
        }
        .onChange(of: realtimeDate.date){ date in
            //現在時刻に関して再描画
            for scheduleItem in scheduleItems{
                scheduleItem.currentDate = date
            }
        }
    }
}

//※1: https://stackoverflow-com.translate.goog/questions/66185737/swiftui-scrollview-and-onlongpressgesture?_x_tr_sl=en&_x_tr_tl=ja&_x_tr_hl=ja&_x_tr_pto=sc
