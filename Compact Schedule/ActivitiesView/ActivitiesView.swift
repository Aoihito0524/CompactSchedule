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
    let spacingBetweenActivityAndTasksRow = DEVICE_HEIGHT * 0.02
    let scrollViewTopPadding = DEVICE_HEIGHT * 0.18
    let topItemLeadingPadding = DEVICE_WIDTH * 0.13
    let topItemTopPadding = DEVICE_HEIGHT * 0.03
    var body: some View{
        ZStack(alignment: .topLeading){
            ScrollView{
                VStack(spacing: spacingBetweenActivityAndTasksRow){
                    ForEach(activities, id: \.id){ activity in
                        ActivityAndTasksRow(activity: activity)
                    }
                    AddActivityRow()
                }
                .padding(.top, scrollViewTopPadding)
                .frame(width: DEVICE_WIDTH) //これを入れないと幅内に入らないshadowが削れる
            }
            topItem_ActivitiesView()
                .padding(.leading, topItemLeadingPadding)
                .padding(.top, topItemTopPadding)
        }
        .background(BACKGROUND_GRAY_COLOR)
    }
}
