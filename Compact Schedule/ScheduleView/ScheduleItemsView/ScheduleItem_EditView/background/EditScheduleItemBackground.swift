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
    let shadowColor = Color.black.opacity(0.35)
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .shadowWithBlur(color: shadowColor, ratio: 1, x: 10, y: 15)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .strokeRoundedRectangle(borderColor, width: borderWidth, cornerRadius: cornerRadius)
        }
        .frame(width: width, height: height)
    }
}

extension View{
    func shadowWithBlur(color: Color, ratio: CGFloat, x: CGFloat, y: CGFloat) -> some View{
        return self
            .background(
                Rectangle().fill(color)
                    .mask {
                        self.scaleEffect(ratio)
                    }
                    .offset(x: x, y: y)
                    .blur(radius: 8, opaque: false)
            )
    }
}
