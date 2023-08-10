//
//  ShortTickMark.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct ShortTickMark: View{
    let length = DEVICE_WIDTH * 0.02 //目盛りの長さ
    var body: some View{
        TickMark(length: length)
    }
}
