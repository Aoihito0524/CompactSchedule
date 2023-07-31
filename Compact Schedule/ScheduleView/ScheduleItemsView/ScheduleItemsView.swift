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
    @Binding var currentOperate: ScheduleView.Operates
    var body: some View{
        ZStack{
            ForEach(scheduleItems, id: \.startDate){item in
                ScheduleItem_DisplayView(scheduleItem: item, editingItem: $editingItem, currentOperate: $currentOperate)
            }
        }
    }
}

//※1: https://stackoverflow-com.translate.goog/questions/66185737/swiftui-scrollview-and-onlongpressgesture?_x_tr_sl=en&_x_tr_tl=ja&_x_tr_hl=ja&_x_tr_pto=sc
