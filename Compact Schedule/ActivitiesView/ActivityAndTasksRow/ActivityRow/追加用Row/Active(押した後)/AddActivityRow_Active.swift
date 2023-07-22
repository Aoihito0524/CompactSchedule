//
//  AddActivityRow_Inactive.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct AddActivityRow_Active: View{
    @ObservedObject var activityManager: ActivityManager
    @Binding var isActive: Bool
    @ObservedObject var VM: AddActivityRow_ActiveViewModel
    @State var color = Color.white //@Stateだけどletとして使ってます
    let addTextColor = Color.black
    init(isActive: Binding<Bool>, activityManager: ActivityManager){
        self._isActive = isActive
        self.activityManager = activityManager
        VM = AddActivityRow_ActiveViewModel(activityManager: activityManager)
    }
    var body: some View{
        ZStack{
            ActivityRowFrame(color: $color)
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
