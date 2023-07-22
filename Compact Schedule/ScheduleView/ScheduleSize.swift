//
//  ScheduleSize.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

class ScheduleSize{
    static let oneHourHeight = DEVICE_HEIGHT * 0.24
    static var tickMarkHeight_withPadding: CGFloat{ //余白部分も含めた高さ=10分のheight
        get { return oneHourHeight / 6.0 }
    }
}
