//
//  TimeScaleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct TimeScaleView: View{
    let hours_inADay = 24
    @ObservedObject var realtimeDate = RealtimeDate.shared
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            let currentTime = DayHourMinute(date: realtimeDate.date)
            Cliped_OneHourTickMarks(hour: currentTime.hour, minute: currentTime.minute)
            ForEach(1..<hours_inADay){hour in
                let hour = (currentTime.hour + hour) % hours_inADay //現在時刻から24時間分表示し、24で割った余りを求め24時を超えても正しく表示
                OneHourTickMarks(hour: hour)
            }
        }
    }
}
