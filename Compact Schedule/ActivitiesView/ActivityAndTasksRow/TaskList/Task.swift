//
//  Task.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

class Task: ObservableObject, Identifiable{
    @Published var name: String
    @Published var minutes: Int
    let id: String
    init(name: String, minutes: Int){
        self.id = UUID().uuidString
        self.name = name
        self.minutes = minutes
    }
}
