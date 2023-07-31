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
    var body: some View{
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(width: width, height: height)
    }
}
