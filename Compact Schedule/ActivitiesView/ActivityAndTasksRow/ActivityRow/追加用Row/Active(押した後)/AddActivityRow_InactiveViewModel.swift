//
//  AddActivityRow_InactiveViewModel.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

class AddActivityRow_ActiveViewModel: ObservableObject{
    @Published var newActivityName = ""
    private var activityManager: ActivityManager
    init(activityManager: ActivityManager){
        self.activityManager = activityManager
    }
    func AddActivity(){
        let colors = activityManager.Colors
        let colorIndex = activityManager.Activities.count % colors.count
        let newActivity = Activity(name: newActivityName, color: colors[colorIndex])
        activityManager.AddActivity(newActivity)
    }
}
