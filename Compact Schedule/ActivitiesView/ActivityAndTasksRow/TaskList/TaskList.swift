//
//  TaskList.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct TaskList: View{
    @ObservedObject var activity: Activity
    let contentsWidth = ActivityAndTasksRowSize.width * 0.9
    var body: some View{
        VStack(alignment: .leading){
            ForEach(activity.tasks){ task in
                TaskRow(task: task)
            }
            Button("+ タスクを追加"){
                let newTask = Task(name: "", minutes: 20)
                activity.AddTask(newTask)
            }
            .foregroundColor(Color.black)
            .padding()
        }
        .frame(width: contentsWidth)
    }
}
