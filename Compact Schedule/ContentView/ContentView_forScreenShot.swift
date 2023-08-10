//
//  ContentView_forScreenShot.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/05.
//

import SwiftUI
import RealmSwift

struct ContentView_forScreenShot: View {
    @State var selection = 0
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selection){
                ScheduleView()
                    .tag(0)
                ActivitiesView()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            TagButtons(selection: $selection){
                TagButton(selection: $selection, index: 0, text: "予定表")
                TagButton(selection: $selection, index: 1, text: "タスク")
            }
            .padding(.bottom)
        }
        .background(BACKGROUND_GRAY_COLOR)
        .ignoresSafeArea()
        .onAppear{
            try! realm_.write{
                realm_.deleteAll()
            }
            let activity1 = Activity(name: "テスト勉強", activityColor: ActivityColor(colorIndex: 0))
            let activity2 = Activity(name: "読書", activityColor: ActivityColor(colorIndex: 1))
            let activity3 = Activity(name: "健康習慣", activityColor: ActivityColor(colorIndex: 2))
            activity1.AddTask(Task(name: "数学の問題集", minutes: 40))
            activity1.AddTask(Task(name: "英作文", minutes: 50))
            activity1.AddTask(Task(name: "国語ワーク", minutes: 30))
            activity2.AddTask(Task(name: "続きを読む", minutes: 30))
            activity3.AddTask(Task(name: "筋トレをする", minutes: 20))
            Activity.Add(activity1)
            Activity.Add(activity2)
            Activity.Add(activity3)
            let schedule1 = ScheduleItem(task: activity1.tasks[0], activity: activity1, tapHeight: DEVICE_HEIGHT * 0.2)
            let schedule2 = ScheduleItem(task: activity3.tasks[0], activity: activity3, tapHeight: DEVICE_HEIGHT * 0.375)
            let schedule3 = ScheduleItem(task: activity2.tasks[0], activity: activity2, tapHeight: DEVICE_HEIGHT * 0.52)
            ScheduleItem.Add(schedule1)
            ScheduleItem.Add(schedule2)
            ScheduleItem.Add(schedule3)
        }
    }
}
