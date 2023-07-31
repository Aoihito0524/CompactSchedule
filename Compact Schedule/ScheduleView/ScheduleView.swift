//
//  ScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/16.
//

import SwiftUI
import RealmSwift

struct ScheduleView: View{
    @State var editingItem: ScheduleItem?
    @State var tapLocation = CGPoint.zero
    @State var scrollOffset: CGFloat = 0.0
    @State var currentOperate = Operates.Default
    enum Operates{
        case Default
        case AddPopup
        case selectNewPopup
        case EditSchedule
    }
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
                                ZStack{
                                    ScheduleItemsView(editingItem: $editingItem, currentOperate: $currentOperate)
                                    if currentOperate == .EditSchedule{
                                        ScheduleItem_EditView(editingItem: editingItem!.Copy().freeze(), scrollOffset: $scrollOffset)
                                    } //@ObservedResultsはRealmオブジェクトを変更した時、View内の全ての子ビューをオブジェクトとの関係に関わらず再描画してしまうため、EditScheduleItemViewは@ObservedResultsを持たないビューの子ビューでないといけない。
                                }
                            }
                            .overlay{
                                //追加ボタン
                                if currentOperate == .AddPopup{
                                    AddScheduleButton(currentOperate: $currentOperate, tapPosition: TapPosition())
                                }
                                //選択画面
                                if currentOperate == .selectNewPopup{
                                    SelectNewScheduleView(currentOperate: $currentOperate, editingItem: $editingItem, tapHeight: TapPosition().y)
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
