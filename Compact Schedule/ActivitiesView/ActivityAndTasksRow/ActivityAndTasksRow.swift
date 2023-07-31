//
//  ActivityAndTasksRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct ActivityAndTasksRow: View{
    @ObservedRealmObject var activity: Activity
    @State var isOpen = false
    let taskListBackgroundColor = Color.white
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(taskListBackgroundColor)
                .frame(width: ActivityAndTasksRowSize.width)
            VStack{
                ActivityRow(activity: activity, listIsOpen: $isOpen)
                if isOpen{
                    TaskList(activity: activity)
                }
            }
        }
    }
}
class ActivityAndTasksRowSize{
    static let width = DEVICE_WIDTH*0.7
}
