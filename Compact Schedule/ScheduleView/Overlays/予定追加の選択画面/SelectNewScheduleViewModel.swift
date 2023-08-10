//
//  SelectNewScheduleViewModel.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI

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
