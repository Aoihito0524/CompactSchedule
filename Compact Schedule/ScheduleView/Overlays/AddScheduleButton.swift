//
//  AddScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct AddScheduleButton: View{
    @Binding var currentOperate: ScheduleViewModel.Operates
    let tapPosition: CGPoint
    var body: some View{
        Button("予定を追加"){
            currentOperate = .selectNewPopup
        }
        .position(tapPosition)
    }
}
