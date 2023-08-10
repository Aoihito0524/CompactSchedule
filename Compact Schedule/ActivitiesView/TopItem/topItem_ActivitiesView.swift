//
//  topItem_ActivitiesView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI

struct topItem_ActivitiesView: View{
    let backgroundColor = Color(red: 156.0/255.0, green: 255.0/255.0, blue: 190.0/255.0)
    let width = DEVICE_WIDTH * 0.65
    let height = DEVICE_HEIGHT * 0.1
    let cornerRadius: CGFloat = 20
    let shadowRadius: CGFloat = 4
    let shadowOffsetY: CGFloat = 4
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor)
                .shadow(radius: shadowRadius, y: shadowOffsetY)
            HStack{
                Text("活動")
                    .padding()
                Spacer()
                Image(systemName: "figure.cooldown")
                    .padding()
            }
        }
        .frame(width: width, height: height)
    }
}
