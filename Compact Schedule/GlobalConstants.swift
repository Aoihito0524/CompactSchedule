//
//  GlobalConstants.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/23.
//

import SwiftUI
import RealmSwift

let DEVICE_WIDTH = UIScreen.main.bounds.width
let DEVICE_HEIGHT = UIScreen.main.bounds.height
let BACKGROUND_GRAY_COLOR = Color(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0)

//realmはすでに定義されてて使えないため_をつけた
//多分Objectクラスにrealmが定義されてる
var realm_: Realm{
    get{
        return try! Realm()
    }
}
