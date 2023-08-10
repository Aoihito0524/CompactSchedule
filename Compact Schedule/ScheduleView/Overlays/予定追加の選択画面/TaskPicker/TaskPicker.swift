//
//  TaskPicker.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI
import RealmSwift

struct TaskPicker: View{
    @ObservedResults(ScheduleItem.self) var scheduleItems
    @Binding var selection: Int
    @Binding var selectedActivity: Activity?
    var body: some View{
        Picker("", selection: $selection) {
            if let selectedActivity = selectedActivity{
                ForEach(0..<selectedActivity.tasks.count, id: \.self){index in
                    let task = selectedActivity.tasks[index]
                    if !isAlreadyInShcedule(task: task){
                        Text(task.name).font(.caption)
                            .tag(index)
                    }
                }
            }
        }
        .pickerStyle(.wheel)
        .onChange(of: selection){index in
            if let selectedActivity = selectedActivity{
                print("\(selectedActivity.tasks[index])が選択されました")
            }
        }
        .onChange(of: selectedActivity){ _ in
            SetInitialSelection()
        }
    }
    func isAlreadyInShcedule(task: Task) -> Bool{
        return Array(scheduleItems).map({$0.task.id}).contains(task.id)
    }
    func SetInitialSelection(){
        if let activity = selectedActivity{
            for index in 0..<activity.tasks.count{
                print(activity.tasks[index].name)
                if isAlreadyInShcedule(task: activity.tasks[index]){continue;}
                selection = index
                print(selection)
                return;
            }
        }
    }
}
