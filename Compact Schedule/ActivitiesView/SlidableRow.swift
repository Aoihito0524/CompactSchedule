//
//  SlidableRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/25.
//

import SwiftUI

struct SlidableRow<T: View>: View{
    @ViewBuilder var content: () -> T
    @ObservedObject var slideObserver: SlideObserver
    init(minOffset: CGFloat, maxOffset: CGFloat, content: @escaping () -> T){
        self.content = content
        slideObserver = SlideObserver(minOffset: minOffset, maxOffset: maxOffset)
    }
    var body: some View{
        return content()
        .offset(x: slideObserver.offset)
        .gesture(DragGesture(minimumDistance: 3.0)
            .onChanged{value in
                let location = value.location
                if slideObserver.isDragStart{
                    slideObserver.SetDragInfo_AtStart(location: location)
                    slideObserver.isDragStart = false
                }
                slideObserver.SetOffset(location: location)
            }
            .onEnded{_ in
                slideObserver.isDragStart = true
            })
    }
}
