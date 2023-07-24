//
//  TaskRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct TaskRow: View{
    @ObservedObject var task: Task
    @State var isDragStart = true
    let markColor = Color(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0)
    let minutesButtonColor = Color.white
    let width = ActivityAndTasksRowSize.width * 0.9
    init(task: Task){
        self.task = task
    }
    var body: some View{
        DeletableRow(rowWidth: width){
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
}


class DeleteDragObserver: ObservableObject{
    @Published var StartLocation = CGPoint.zero
    @Published var offset = CGFloat.zero
    @Published var isDragStart = true
    let minOffset: CGFloat
    let maxOffset: CGFloat
    init(minOffset: CGFloat, maxOffset: CGFloat){
        self.minOffset = minOffset
        self.maxOffset = maxOffset
    }
    func SetDragInfo_AtStart(location: CGPoint){
        StartLocation = location
    }
    func SetOffset(location: CGPoint){
        offset = location.x - StartLocation.x
        if offset < minOffset{
            offset = minOffset
        }
        else if offset > maxOffset{
            offset = maxOffset
        }
    }
}

struct DeletableRow<T: View>: View{
    let rowWidth: CGFloat
    @ViewBuilder var content: () -> T
    @ObservedObject var deleteDragObserver: DeleteDragObserver
    let deleteButtonWidth = DEVICE_WIDTH * 0.14
    let deleteButtonHeight = DEVICE_HEIGHT * 0.05
    var minOffset = -DEVICE_WIDTH * 0.16
    init(rowWidth: CGFloat, content: @escaping () -> T){
        self.rowWidth = rowWidth
        self.content = content
        deleteDragObserver = DeleteDragObserver(minOffset: minOffset, maxOffset: 0)
    }
    var body: some View{
        return HStack{
            content()
            Spacer()
            Button(action: {}){
                ZStack{
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.red)
                        .frame(width: deleteButtonWidth, height: deleteButtonHeight)
                    Text("削除")
                        .foregroundColor(Color.black)
                }
            }
        }
        .offset(x: deleteDragObserver.offset)
        .frame(width: rowWidth + abs(minOffset))
        .gesture(DragGesture(minimumDistance: 3.0)
            .onChanged{value in
                let location = value.location
                if deleteDragObserver.isDragStart{
                    deleteDragObserver.SetDragInfo_AtStart(location: location)
                    deleteDragObserver.isDragStart = false
                }
                deleteDragObserver.SetOffset(location: location)
            }
            .onEnded{_ in
                deleteDragObserver.isDragStart = true
            })
        .frame(width: rowWidth, alignment: .leading)
        .clipped()
    }
}
