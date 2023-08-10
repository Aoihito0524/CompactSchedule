//
//  topItem_ScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI

struct topItem_ScheduleView: View{
    let backgroundColor = Color(red: 182.0/255.0, green: 237.0/255.0, blue: 255.0/255.0)
    let width = DEVICE_WIDTH * 0.8
    let height = DEVICE_HEIGHT * 0.1
    let cornerRadius: CGFloat = 20
    let shadowRadius: CGFloat = 4
    let shadowOffsetY: CGFloat = 4
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
                .shadow(radius: shadowRadius, y: shadowOffsetY)
                .frame(width: width, height: height)
                .overlay{
                    HStack{
                        Text("スケジュール")
                        Image(systemName: "clock")
                    }
                }
        }
    }
}
