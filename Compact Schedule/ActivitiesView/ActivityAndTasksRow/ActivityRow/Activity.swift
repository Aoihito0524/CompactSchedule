//
//  Activity.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

class Activity: ObservableObject{
    @Published var name: String
    @Published var color: Color
    @Published var tasks: [Task]
    let id: String
    init(name: String, color: Color){
        self.name = name
        self.color = color
        self.tasks = []
        self.id = UUID().uuidString
    }
    func AddTask(_ task: Task){
        tasks.append(task)
    }
}
