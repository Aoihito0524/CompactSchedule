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
    init(activity: Activity, listIsOpen: Binding<Bool>){
        self.activity = activity
        self._listIsOpen = listIsOpen
    }
    var body: some View{
        ZStack(alignment: .trailing){
            Button(action: {Activity.Delete(activity.thaw()!)}){
                Image(systemName: "trash")
                    .foregroundColor(Color.black)
            }
            SlidableRow(minOffset: -DEVICE_WIDTH * 0.1, maxOffset: 0){
                ZStack{
                    ActivityRowFrame(color: activity.color)
                        .onTapGesture{
                            listIsOpen.toggle()
                        }
                    HStack{
                        TextField("", text: $activity.name)
                            .padding()
                        Spacer()
                        Image(systemName: symbolImageName)
                            .padding()
                    }
                }
                .frame(width: ActivityAndTasksRowSize.width)
            }
        }
    }
}

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

