//
//  Cliped_OneHourTickMarks.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct Cliped_OneHourTickMarks: View{
    let hour: Int
    let minute: Int
    var body: some View{
        OneHourTickMarks(hour: hour)
            .frame(height: Height(), alignment: .bottom) //alignment: .bottomはframeで拡張、切り取りするときの自身の位置だった
            .clipped()
    }
    func Height() -> CGFloat{ //ScheduleSizeに定めた時間と間隔の対応からどこまで映すか決める
        let minutesInAnHour = 60
        let minutesLeft = minutesInAnHour - minute
        return ScheduleSize.oneHourHeight * CGFloat(minutesLeft) / CGFloat(minutesInAnHour)
    }
}
