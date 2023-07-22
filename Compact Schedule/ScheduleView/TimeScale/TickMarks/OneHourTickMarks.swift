//
//  OneHourTickMarks.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct OneHourTickMarks: View{//時刻文字も含む
    let hour: Int
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            HStack{
                LongTickMark()
                Text("\(hour) : 00")
            }
            ShortTickMark()
            ShortTickMark()
            LongTickMark()
            ShortTickMark()
            ShortTickMark()
        }
        .frame(height: ScheduleSize.oneHourHeight)
    }
}
