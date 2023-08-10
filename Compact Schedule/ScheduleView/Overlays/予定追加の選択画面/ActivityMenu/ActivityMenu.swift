//
//  ActivityMenu.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI
import RealmSwift

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
