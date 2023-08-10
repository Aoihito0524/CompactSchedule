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
    let cornerRadius: CGFloat = 10
    let shadowRadius: CGFloat = 4
    let shadowOffsetY: CGFloat = 4
    var body: some View{
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(width: width, height: height)
            .shadow(radius: shadowRadius, y: shadowOffsetY)
    }
}
