//
//  RealtimeDate.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/02.
//

import SwiftUI

class RealtimeDate: ObservableObject{
    static var shared = RealtimeDate()
    @Published var date = Date()
    @State var timer: Timer?
    func SetTimer(){
        let oneMin_seconds = 60.0
        timer = Timer.scheduledTimer(withTimeInterval: oneMin_seconds, repeats: true) { _ in
            self.date = Date()
        }
    }
    func StopTimer(){
        if let timer = timer{
            timer.invalidate()
        }
    }
}
