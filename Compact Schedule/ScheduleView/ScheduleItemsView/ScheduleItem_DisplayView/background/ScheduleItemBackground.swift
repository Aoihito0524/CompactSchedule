//
//  ScheduleItemBackground.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/31.
//

import SwiftUI

struct ScheduleItemBackground: View{
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let color: Color
    let shadowColor = Color.black.opacity(0.25)
    let shadowRadius: CGFloat = 2
    let shadowOffsetY: CGFloat = 4
    var body: some View{
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(width: width, height: height)
            .shadow(color: shadowColor, radius: shadowRadius, y: shadowOffsetY)
    }
}
