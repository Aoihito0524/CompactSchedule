//
//  ActivityRowSize.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct ActivityRowFrame: View{
    let color: Color
    let width = ActivityAndTasksRowSize.width
    let height = DEVICE_HEIGHT*0.06
    var body: some View{
        RoundedRectangle(cornerRadius: 10)
            .fill(color)
            .frame(width: width, height: height)
            .shadow(radius: 4, y: 4)
    }
}
