//
//  ScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/16.
//

import SwiftUI

struct ScheduleView: View{
    @State var scheduleItems = [ScheduleItem]()
    @State var editingItem: ScheduleItem?
    @State var tapLocation = CGPoint.zero
    @State var currentOperate = Operates.Default
    enum Operates{
        case Default
        case AddPopup
        case selectNewPopup
        case EditSchedule
    }
    @State var scrollOffset: CGFloat = 0.0
    var body: some View{
        ZStack(alignment: .top){
            Rectangle().fill(BACKGROUND_GRAY_COLOR)
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    Rectangle().fill(Color.clear)
                        .frame(height: DEVICE_HEIGHT * 0.18)
                    ZStack{
                        ScrollPosReader()
                        ZStack{
                            Rectangle().fill(BACKGROUND_GRAY_COLOR)
                                .onTapGesture{ location in
                                    print("スケジュールがタップされました")
                                    tapLocation = location
                                    toggle_AddPopupOrNot() //追加ボタンの表示/非表示切り替え
                                }
                            HStack{
                                //時間と目盛り
                                TimeScaleView()
                                Spacer()
                                //予定名と枠
                                ScheduleItemsView(scheduleItems: $scheduleItems,  scrollOffset: $scrollOffset, editingItem: $editingItem, currentOperate: $currentOperate)
                            }
                            //追加ボタン
                            .overlay{
                                if currentOperate == .AddPopup{
                                    AddScheduleButton(currentOperate: $currentOperate, tapPosition: TapPosition())
                                }
                            }
                            //選択画面
                            .overlay{
                                if currentOperate == .selectNewPopup{
                                    SelectNewScheduleView(currentOperate: $currentOperate, editingItem: $editingItem, scheduleItems: $scheduleItems, tapHeight: TapPosition().y)
                                }
                            }
                        }
                    }.onPreferenceChange(posKey.self) { value in
                        scrollOffset = value
                    }
                }
            }
            topItem_ScheduleView()
                .padding(.top, DEVICE_HEIGHT * 0.03)
        }
    }
    func toggle_AddPopupOrNot(){
        if currentOperate == .Default{
            currentOperate = .AddPopup
        }
        else{
            currentOperate = .Default
        }
    }
    func TapPosition() -> CGPoint{
        return CGPoint(x: tapLocation.x, y: tapLocation.y - scrollOffset)
    }
}

struct ScrollPosReader: View{
    var body: some View{
        GeometryReader { geometry in
            Rectangle().fill(Color.clear)
                .preference(key: posKey.self, value:   geometry.frame(in: .global).minY)
        }
    }
}

struct posKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct topItem_ScheduleView: View{
    let backgroundColor = Color(red: 182.0/255.0, green: 237.0/255.0, blue: 255.0/255.0)
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .shadow(radius: 4, y: 4)
                .frame(width: DEVICE_WIDTH * 0.8, height: DEVICE_HEIGHT * 0.1)
                .overlay{
                    HStack{
                        Text("スケジュール")
                        Image(systemName: "clock")
                    }
                }
        }
    }
}
