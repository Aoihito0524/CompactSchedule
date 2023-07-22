//
//  TickMark.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct TickMark: View{
    let length: CGFloat
    let tickMark_lineWidth = DEVICE_HEIGHT * 0.001
    var body: some View{
        VStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: length, height: tickMark_lineWidth)
            Spacer()
        }
        .frame(height: ScheduleSize.tickMarkHeight_withPadding)
    }
}
