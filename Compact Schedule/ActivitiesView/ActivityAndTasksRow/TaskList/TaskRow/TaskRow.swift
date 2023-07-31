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
    let markColor = Color(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0)
    let minutesButtonColor = Color.white
    let width = ActivityAndTasksRowSize.width * 0.9
    var body: some View{
        DeletableRow(rowWidth: width, delete: DeleteTask){
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(markColor)
                    .frame(width:DEVICE_WIDTH * 0.021, height: DEVICE_HEIGHT * 0.033)
                TextField("", text: $task.name)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(minutesButtonColor)
                        .shadow(radius: 2)
                    HStack(alignment: .bottom){
                        Spacer()
                        Text("２０").font(.caption2)
                        Text("分").font(.caption2)
                        Spacer()
                    }
                }
                .frame(width: DEVICE_WIDTH * 0.11, height: DEVICE_HEIGHT * 0.026)
                .padding()
            }.frame(width: width)
        }
    }
    func DeleteTask(){
        Task.Delete(task.thaw()!)
    }
}
