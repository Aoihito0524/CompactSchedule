//
//  SelectNewScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct SelectNewScheduleView: View{
    @ObservedResults(Activity.self) var activities
    @State var selectedActivity: Activity?
    @State var selection = 0
    @Binding var currentOperate: ScheduleView.Operates
    @Binding var editingItem: ScheduleItem?
    let tapHeight: CGFloat
    let width = DEVICE_WIDTH * 0.8
    let height = DEVICE_HEIGHT * 0.15
    var body: some View{
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: Color.black, radius: 5)
                VStack(alignment: .leading){
                    HStack{
                        Text("新しいスケジュール")
                            .padding()
                        Menu(selectedActivity == nil ? "活動を選択" : selectedActivity!.name){
                            ForEach(activities, id: \.id){ activity in
                                Button(activity.name){
                                    selectedActivity = activity
                                }
                            }
                        }
                    }
                    HStack{
                        Picker("", selection: $selection) {
                            if let selectedActivity = selectedActivity{
                                ForEach(selectedActivity.tasks, id: \.id){task in
                                    Text(task.name).font(.caption)
                                }
                            }
                        }
                        .pickerStyle(.wheel)
                        Button("追加"){
                            if selectedActivity == nil{ print("activity not selected"); return; }
                            let task = selectedActivity!.tasks[selection]
                            let newItem = ScheduleItem(task: task, activity: selectedActivity!, tapHeight: tapHeight)
                            editingItem = newItem
                            ScheduleItem.Add(newItem)
                            currentOperate = .EditSchedule
                        }
                        .padding()
                    }
                }
            }.frame(width: width, height: height)
            Spacer()
        }.padding(.top, tapHeight)
    }
}
