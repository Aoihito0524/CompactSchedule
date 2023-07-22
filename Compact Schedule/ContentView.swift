//
//  ContentView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            ScheduleView()
                .tabItem {
                    VStack{
                        Image(systemName: "tablecells.badge.ellipsis")
                        Text("予定表")
                    }
                }
            ActivitiesView()
                .tabItem {
                    VStack{
                        Image(systemName: "newspaper")
                        Text("タスクリスト")
                    }
                }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
