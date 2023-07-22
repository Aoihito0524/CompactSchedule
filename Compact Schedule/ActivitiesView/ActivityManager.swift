//
//  ActivityManager.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

class ActivityManager: ObservableObject{
    static let shared = ActivityManager()
    @Published var Activities: [Activity]
    let Colors = [Color(red: 255.0/255.0, green: 238.0/255.0, blue: 148.0/255.0),
                  Color(red: 197.0/255.0, green: 209.0/255.0, blue: 255.0/255.0),
                  Color(red: 255.0/255.0, green: 165.0/255.0, blue: 165.0/255.0)]
    func AddActivity(_ activity: Activity){
        Activities.append(activity)
    }
    init(){
        self.Activities = []
    }
}
