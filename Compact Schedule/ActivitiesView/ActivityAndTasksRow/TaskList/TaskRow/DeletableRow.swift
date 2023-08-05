//
//  DeletableRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/25.
//

import SwiftUI

struct DeletableRow<T: View>: View{
    let rowWidth: CGFloat
    let delete: () -> ()
    @ViewBuilder var content: () -> T
    let deleteButtonWidth = DEVICE_WIDTH * 0.14
    let deleteButtonHeight = DEVICE_HEIGHT * 0.05
    var minOffset = -DEVICE_WIDTH * 0.16
    var body: some View{
        return SlidableRow(minOffset: minOffset, maxOffset: 0){
            HStack{
                content()
                Spacer()
                Button(action: {delete()}){
                    ZStack{
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.red)
                            .frame(width: deleteButtonWidth, height: deleteButtonHeight)
                        Text("削除")
                            .foregroundColor(Color.black)
                    }
                }
            }
            .frame(width: rowWidth + abs(minOffset))
        }
        .frame(width: rowWidth, alignment: .leading)
        .clipped()
        .contentShape(Rectangle()) //※1 非表示エリアのタップを防ぐ
    }
}

//※1: https://qiita.com/ShinTTK/items/9c8899dfe52770ce559b
