//
//  AddTaskButton.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/28.
//

import SwiftUI
import RealmSwift

struct AddTaskButton: View{
    @ObservedRealmObject var activity: Activity
    var body: some View{
        Button("+ タスクを追加"){
            let newTask = Task(name: "", minutes: 20)
            activity.thaw()!.AddTask(newTask)
        }
    }
}
