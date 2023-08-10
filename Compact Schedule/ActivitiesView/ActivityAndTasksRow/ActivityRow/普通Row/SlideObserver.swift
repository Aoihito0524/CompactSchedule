//
//  SlideObserver.swift
//  
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI

class SlideObserver: ObservableObject{
    @Published var StartLocation = CGPoint.zero
    @Published var offset = CGFloat.zero
    @Published var isDragStart = true
    let minOffset: CGFloat
    let maxOffset: CGFloat
    init(minOffset: CGFloat, maxOffset: CGFloat){
        self.minOffset = minOffset
        self.maxOffset = maxOffset
    }
    func SetDragInfo_AtStart(location: CGPoint){
        StartLocation = location
    }
    func SetOffset(location: CGPoint){
        offset = location.x - StartLocation.x
        if offset < minOffset{
            offset = minOffset
        }
        else if offset > maxOffset{
            offset = maxOffset
        }
    }
}
