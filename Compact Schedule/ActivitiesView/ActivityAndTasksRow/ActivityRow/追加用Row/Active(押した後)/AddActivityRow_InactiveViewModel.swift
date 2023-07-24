//
//  AddActivityRow_InactiveViewModel.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

class AddActivityRow_ActiveViewModel: ObservableObject{
    @Published var newActivityName = ""
    func AddActivity(){
        let activitiesCount = Activity.loadAll().count
        let colorIndex = activitiesCount % ActivityColor.numColors
        let color = ActivityColor(colorIndex: colorIndex)
        let newActivity = Activity(name: newActivityName, activityColor: color)
        Activity.Add(newActivity)
    }
}
