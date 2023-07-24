//
//  ActivityRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
struct ActivityRow: View{
    @ObservedObject var activity: Activity
    @Binding var listIsOpen: Bool
    var symbolImageName: String{
        get{ return listIsOpen ? "minus" : "plus"; }
    }
    var body: some View{
        ZStack{
            ActivityRowFrame(color: activity.color)
            HStack{
                Text(activity.name)
                    .padding()
                Spacer()
                Image(systemName: symbolImageName)
                    .padding()
            }
        }
        .frame(width: ActivityAndTasksRowSize.width)
        .onTapGesture{
            listIsOpen.toggle()
        }
    }
}
