//
//  SelectNewScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct SelectNewScheduleView: View{
    @Binding var currentOperate: ScheduleViewModel.Operates
    @ObservedObject var VM: SelectNewScheduleViewModel
    @Binding var editingItem: ScheduleItem?
    let tapHeight: CGFloat
    let width = DEVICE_WIDTH * 0.8
    let height = DEVICE_HEIGHT * 0.15
    let backgroundCornerRadius: CGFloat = 15
    let backgroundShadoRadius: CGFloat = 5
    init(currentOperate: Binding<ScheduleViewModel.Operates>, editingItem: Binding<ScheduleItem?>, tapHeight: CGFloat){
        self._editingItem = editingItem
        self._currentOperate = currentOperate
        self.tapHeight = tapHeight
        self.VM = SelectNewScheduleViewModel(tapHeight: tapHeight)
    }
    func SetEditingItem(_ item: ScheduleItem){
        editingItem = item
    }
    var body: some View{
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: backgroundCornerRadius)
                    .fill(Color.white)
                    .shadow(color: Color.black, radius: backgroundShadoRadius)
                VStack(alignment: .leading){
                    HStack{
                        Text("新しいスケジュール")
                            .padding()
                        ActivityMenu(selectedActivity: $VM.selectedActivity)
                    }
                    HStack{
                        TaskPicker(selection: $VM.taskSelection, selectedActivity: $VM.selectedActivity)
                        Button("追加"){
                            if !VM.TaskIsDecided(){ return; }
                            VM.AddSchedule(setEditingItem: SetEditingItem)
                            currentOperate = .EditSchedule
                        }
                        .padding()
                    }
                }
            }.frame(width: width, height: height)
            Spacer()
        }.padding(.top, tapHeight)
    }
}

