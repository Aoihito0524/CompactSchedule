//
//  AddActivityRow_Active.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct AddActivityRow_Inactive: View{
    @Binding var isActive: Bool
    let color = Color.white
    var body: some View{
        Button(action: {
            isActive = true
        }){
            ZStack{
                ActivityRowFrame(color: color)
                Text("活動を追加")
            }
        }
    }
}


