//
//  Task_RowMark.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/10.
//

import SwiftUI

struct Task_RowMark: View{
    let color = Color(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0)
    let cornerRadius: CGFloat = 10
    let width: CGFloat = DEVICE_WIDTH * 0.021
    let height: CGFloat = DEVICE_HEIGHT * 0.033
    var body: some View{
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(width: width, height: height)
    }
}
