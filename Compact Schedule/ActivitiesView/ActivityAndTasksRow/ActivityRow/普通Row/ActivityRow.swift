//
//  ActivityRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct ActivityRow: View{
    @ObservedRealmObject var activity: Activity
    @Binding var listIsOpen: Bool
    var symbolImageName: String{
        get{ return listIsOpen ? "minus" : "plus"; }
    }
    let slideMinOffset = -DEVICE_WIDTH * 0.1
    let slideMaxOffset: CGFloat = 0
    var body: some View{
        ZStack(alignment: .trailing){
            Button(action: {Activity.Delete(activity.thaw()!)}){
                Image(systemName: "trash")
                    .foregroundColor(Color.black)
            }
            SlidableRow(minOffset: slideMinOffset, maxOffset: slideMaxOffset){
                ZStack{
                    ActivityRowFrame(color: activity.color)
                        .onTapGesture{
                            listIsOpen.toggle()
                        }
                    HStack{
                        TextField("", text: $activity.name)
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: symbolImageName)
                            .padding(.horizontal)
                    }
                }
                .frame(width: ActivityAndTasksRowSize.width)
            }
        }
    }
}


