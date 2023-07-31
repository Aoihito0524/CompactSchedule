//
//  EditScheduleItemBackground.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/31.
//

import SwiftUI

struct EditScheduleItemBackground: View{
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let color: Color
    let borderColor = Color(red: 186.0/255.0, green: 186.0/255.0, blue: 186.0/255.0)
    let borderWidth = DEVICE_WIDTH * 0.003
    var body: some View{
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .strokeRoundedRectangle(borderColor, width: borderWidth, cornerRadius: cornerRadius)
            .frame(width: width, height: height)
    }
}
