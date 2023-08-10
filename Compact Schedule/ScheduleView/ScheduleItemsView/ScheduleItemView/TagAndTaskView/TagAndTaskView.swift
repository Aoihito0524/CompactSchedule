//
//  TagAndTaskView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/10.
//

import SwiftUI
import RealmSwift

struct TagAndTaskView_VerticalLayout: View{
    @ObservedRealmObject var scheduleItem: ScheduleItem
    let taskTextPadding = DEVICE_WIDTH * 0.05
    var body: some View{
        if scheduleItem.isAlive{
            HStack{
                VStack(alignment: .leading){
                    ActivityTag(activity: scheduleItem.activity)
                    Spacer()
                    Text(scheduleItem.task.name)
                        .padding(.leading, taskTextPadding)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
struct TagAndTaskView_HorizontalLayout: View{
    @ObservedRealmObject var scheduleItem: ScheduleItem
    let taskTextPadding = DEVICE_WIDTH * 0.05
    var body: some View{
        if scheduleItem.isAlive{
            VStack{
                HStack(alignment: .top){
                    ActivityTag(activity: scheduleItem.activity)
                    Text(scheduleItem.task.name)
                        .padding(.leading, taskTextPadding)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
