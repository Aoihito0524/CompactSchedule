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
    let ratioOfBodyToShadow: CGFloat = 1 //等倍だが位置をずらすため影になる
    let shadowOffsetX: CGFloat = 10
    let shadowOffsetY: CGFloat = 15
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .shadowWithBlur(color: shadowColor, ratio: ratioOfBodyToShadow, x: shadowOffsetX, y: shadowOffsetY)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .strokeRoundedRectangle(borderColor, width: borderWidth, cornerRadius: cornerRadius)
        }
        .frame(width: width, height: height)
    }
}

extension View{
    func shadowWithBlur(color: Color, ratio: CGFloat, x: CGFloat, y: CGFloat) -> some View{
        let blurRadius: CGFloat = 8
        return self
            .background(
                Rectangle().fill(color)
                    .mask {
                        self.scaleEffect(ratio)
                    }
                    .offset(x: x, y: y)
                    .blur(radius: blurRadius, opaque: false)
            )
    }
}
