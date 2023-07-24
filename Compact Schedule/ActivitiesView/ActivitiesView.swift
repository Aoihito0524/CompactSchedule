//
//  ActivityiView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

struct ActivitiesView: View{
    @ObservedResults(Activity.self) var activities
    var body: some View{
        ZStack(alignment: .topLeading){
            ScrollView{
                VStack(spacing: DEVICE_HEIGHT * 0.02){
                    ForEach(activities, id: \.name){ activity in
                        ActivityAndTasksRow(activity: activity.Copy())
                    }
                    AddActivityRow()
                }
                .padding(.top, DEVICE_HEIGHT * 0.18)
                .frame(width: DEVICE_WIDTH) //これを入れないと幅内に入らないshadowが削れる
            }
            topItem_ActivitiesView()
                .padding(.leading, DEVICE_WIDTH * 0.13)
                .padding(.top, DEVICE_HEIGHT * 0.03)
        }
        .background(BACKGROUND_GRAY_COLOR)
        .ignoresSafeArea()
    }
}

struct topItem_ActivitiesView: View{
    let backgroundColor = Color(red: 156.0/255.0, green: 255.0/255.0, blue: 190.0/255.0)
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20).fill(backgroundColor)
                .shadow(radius: 4, y: 4)
            HStack{
                Text("活動")
                    .padding()
                Spacer()
                Image(systemName: "figure.cooldown")
                    .padding()
            }
        }
        .frame(width: DEVICE_WIDTH * 0.65, height: DEVICE_HEIGHT * 0.1)
    }
}
