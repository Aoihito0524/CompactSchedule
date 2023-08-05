//
//  SelectNewScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct SelectNewScheduleView: View{
    @Binding var currentOperate: ScheduleView.Operates
    let tapHeight: CGFloat
    let width = DEVICE_WIDTH * 0.8
    let height = DEVICE_HEIGHT * 0.15
    @ObservedObject var VM: SelectNewScheduleViewModel
    @Binding var editingItem: ScheduleItem?
    init(currentOperate: Binding<ScheduleView.Operates>, editingItem: Binding<ScheduleItem?>, tapHeight: CGFloat){
        self._editingItem = editingItem
        self._currentOperate = currentOperate
        self.tapHeight = tapHeight
        self.VM = SelectNewScheduleViewModel(tapHeight: tapHeight)
    }
    func SetEditingItem(_ item: ScheduleItem){
        editingItem = item
    }
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
                        ActivityMenu(selectedActivity: $VM.selectedActivity)
                    }
                    HStack{
                        TaskPicker(selection: $VM.taskSelection, selectedActivity: $VM.selectedActivity)
                        Button("追加"){
                            if !VM.TaskIsDecided(){ return; }
                            VM.AddSchedule(setEditingItem: SetEditingItem)
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
class SelectNewScheduleViewModel: ObservableObject{
    @Published var selectedActivity: Activity?
    @Published var taskSelection = 0
    private let tapHeight: CGFloat
    init(tapHeight: CGFloat) {
        self.tapHeight = tapHeight
    }
    func AddSchedule(setEditingItem: @escaping (ScheduleItem) -> ()){
        let task = selectedActivity!.tasks[taskSelection]
        let newItem = ScheduleItem(task: task, activity: selectedActivity!, tapHeight: tapHeight)
        ScheduleItem.Add(newItem)
        setEditingItem(newItem)
    }
    func TaskIsDecided() -> Bool{
        //Activityが決定するとtaskがpickerに表示されるため、選択したとみなす
        let decided = (selectedActivity != nil)
        if !decided{ print("activity not selected")}
        return decided
    }
}

struct ActivityMenu: View{
    @ObservedResults(Activity.self) var activities
    @Binding var selectedActivity: Activity?
    var body: some View{
        Menu(selectedActivity == nil ? "活動を選択" : selectedActivity!.name){
            ForEach(activities, id: \.id){ activity in
                Button(activity.name){
                    selectedActivity = activity
                }
            }
        }
    }
}
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
