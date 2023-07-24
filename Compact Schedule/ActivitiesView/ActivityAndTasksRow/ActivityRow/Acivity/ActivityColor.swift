//
//  ActivityColor.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/22.
//

import SwiftUI
import RealmSwift

class ActivityColor: Object{
    @Persisted var colorIndex: Int
    var color: Color{
        get{ return ActivityColor.colors[colorIndex] }
    }
    private static let colors =
        [Color(red: 255.0/255.0, green: 238.0/255.0, blue: 148.0/255.0),
         Color(red: 197.0/255.0, green: 209.0/255.0, blue: 255.0/255.0),
         Color(red: 255.0/255.0, green: 165.0/255.0, blue: 165.0/255.0)]
    static var numColors: Int{
        get{ return colors.count }
    }
    override init(){
        super.init()
    }
    init(colorIndex: Int) {
        if ActivityColor.numColors <= colorIndex{print("colorIndexが範囲外です")}
        self.colorIndex = colorIndex
    }
}
