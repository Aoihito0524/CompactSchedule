//
//  AddActivityRow_Inactive.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct AddActivityRow_Active: View{
    @Binding var isActive: Bool
    @ObservedObject var VM = AddActivityRow_ActiveViewModel()
    let color = Color.white
    let addTextColor = Color.black
    var body: some View{
        ZStack{
            ActivityRowFrame(color: color)
            HStack{
                TextField("", text: $VM.newActivityName)
                Button("追加"){
                    VM.AddActivity()
                    isActive = false
                }
                .foregroundColor(addTextColor)
                .padding()
            }
            .frame(width: ActivityAndTasksRowSize.width)
        }
    }
}
