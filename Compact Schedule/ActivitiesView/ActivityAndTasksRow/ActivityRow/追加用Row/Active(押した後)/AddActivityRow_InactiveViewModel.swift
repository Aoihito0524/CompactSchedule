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
//        let activitiesCount = Activity.loadAll().count
//        let colorIndex = activitiesCount % ActivityColor.numColors
//        let color = ActivityColor(colorIndex: colorIndex)
        let color = ColorNotUsedYet()
        let newActivity = Activity(name: newActivityName, activityColor: color)
        Activity.Add(newActivity)
    }
    //最も使われてない色のうち最初のものを返す
    private func ColorNotUsedYet() -> ActivityColor{
        let activities = realm_.objects(Activity.self)
        var colorIndexesUsed = Array(activities).map({($0.activityColor?.colorIndex)!})
        while true{
            for index in 0..<ActivityColor.numColors{
                if colorIndexesUsed.contains(index){
                    colorIndexesUsed.removeFirst(index)
                    continue
                }
                //色が在庫切れになった時ここに来る
                return ActivityColor(colorIndex: index);
            }
            if colorIndexesUsed.count == 0{ break; }//無限ループ対策
        }
        return ActivityColor(colorIndex: 0)
    }
}
