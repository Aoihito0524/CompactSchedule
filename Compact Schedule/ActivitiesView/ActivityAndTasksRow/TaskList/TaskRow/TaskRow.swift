//
//  TaskRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift
struct TaskRow: View{
    @ObservedRealmObject var task: Task
    let width = ActivityAndTasksRowSize.width * 0.9
    var body: some View{
        DeletableRow(rowWidth: width, delete: DeleteTask){
            HStack{
                Task_RowMark()
                TextField("", text: $task.name)
                Spacer()
                DurationPicker(minutes: $task.minutes)
                .frame(width: DEVICE_WIDTH * 0.11, height: DEVICE_HEIGHT * 0.026)
                .padding()
            }.frame(width: width)
        }
    }
    func DeleteTask(){
        Task.Delete(task.thaw()!)
    }
}
