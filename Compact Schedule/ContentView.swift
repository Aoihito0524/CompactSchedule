//
//  ContentView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/16.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selection){
                ScheduleView()
                    .tag(0)
                ActivitiesView()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            TagButtons(selection: $selection){
                TagButton(selection: $selection, index: 0, text: "予定表")
                TagButton(selection: $selection, index: 1, text: "タスク")
            }
            .padding(.bottom)
        }
        .background(BACKGROUND_GRAY_COLOR)
        .ignoresSafeArea()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct TagButtons<T:View>: View{
    @Binding var selection: Int
    let content: () -> T
    init(selection: Binding<Int>, @ViewBuilder content: @escaping () -> T) {
        self._selection = selection
        self.content = content
    }
    var body: some View{
        HStack(spacing: 0){
            content()
            .foregroundColor(Color.black)
            .padding(.horizontal)
        }
    }
}
struct TagButton: View{
    @Binding var selection: Int
    let index: Int
    let text: String
    var body: some View{
        Button(text){
            selection = index
        }
        .fontWeight(selection == index ? .bold : .regular)
    }
}
