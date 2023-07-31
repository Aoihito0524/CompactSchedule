//
//  TaskList.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct TaskList: View{
    @ObservedRealmObject var activity: Activity
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            ForEach(activity.tasks){ task in
                TaskRow(task: task)
            }
            AddTaskButton(activity: activity)
            .foregroundColor(Color.black)
            .padding()
        }
    }
}
