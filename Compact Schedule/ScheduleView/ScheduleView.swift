//
//  ScheduleView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/16.
//

import SwiftUI
import RealmSwift

struct ScheduleView: View{
    @ObservedObject var VM = ScheduleViewModel()
    @Environment(\.scenePhase) var scenePhase
    let scrollViewTopPadding = DEVICE_HEIGHT * 0.18
    let topItemTopPadding = DEVICE_HEIGHT * 0.03
    var body: some View{
        ZStack(alignment: .top){
            ScrollView{
                VStack{
                    ZStack{
                        ScrollPosReader()
                        ZStack{
                            Rectangle().fill(BACKGROUND_GRAY_COLOR)
                                .onTapGesture{ location in
                                    VM.onBackgroundTapped(tapLocation: location)
                                }
                            HStack{
                                //時間と目盛り
                                TimeScaleView()
                                Spacer()
                                //予定名と枠
                                ZStack(alignment: .trailing){
                                    ScheduleItemsView(editingItem: $VM.editingItem, currentOperate: $VM.currentOperate)
                                    if VM.currentOperate == .EditSchedule{
                                        ScheduleItem_EditView(editingItem: VM.editingItem!, currentOperate: $VM.currentOperate, scrollOffset: $VM.scrollOffset)
                                    } //@ObservedResultsはRealmオブジェクトを変更した時、View内の全ての子ビューをオブジェクトとの関係に関わらず再描画してしまうため、EditScheduleItemViewは@ObservedResultsを持たないビューの子ビューでないといけない。
                                }
                            }
                            .overlay{
                                //追加ボタン
                                if VM.currentOperate == .AddPopup{
                                    AddScheduleButton(currentOperate: $VM.currentOperate, tapPosition: VM.TapPosition())
                                }
                                //選択画面
                                if VM.currentOperate == .selectNewPopup{
                                    SelectNewScheduleView(currentOperate: $VM.currentOperate, editingItem: $VM.editingItem, tapHeight: VM.TapPosition().y)
                                }
                            }
                        }
                    }.onPreferenceChange(posKey.self) { value in
                        VM.scrollOffset = value
                    }
                    .padding(.top, scrollViewTopPadding)
                }
            }
            .background(BACKGROUND_GRAY_COLOR)
            topItem_ScheduleView()
                .padding(.top, topItemTopPadding)
        }
        .onAppear{
            RealtimeDate.shared.SetTimer()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                RealtimeDate.shared.date = Date()
                RealtimeDate.shared.SetTimer()
            }
            if phase == .inactive {
                RealtimeDate.shared.StopTimer()
            }
        }
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
