//
//  ScheduleItemView.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift
        
struct ScheduleItemView<T: View>: View{
    @ObservedRealmObject var scheduleItem: ScheduleItem
    @ViewBuilder var backgroundContent: (CGFloat, CGFloat, CGFloat, Color) -> T
    let width = DEVICE_WIDTH * 0.6
    let paddingWidth = DEVICE_WIDTH * 0.05
    var height: CGFloat{
        get{ return scheduleItem.GetBottomHeight() - scheduleItem.GetTopHeight(); }
    }
    let cornerRadius = ScheduleItemViewSize.cornerRadius
    let thresholdHeight_LayoutChange = DEVICE_HEIGHT * 0.08
    var body: some View{
        if scheduleItem.isAlive{
            ZStack(alignment: .leading){
                //予定の背景部分
                backgroundContent(width, height, cornerRadius, scheduleItem.activity.color)
                //予定の文字部分
                ZStack{
                    if GetFrameHeight() < thresholdHeight_LayoutChange{
                        TagAndTaskView_HorizontalLayout(scheduleItem: scheduleItem)
                    }
                    else{
                        TagAndTaskView_VerticalLayout(scheduleItem: scheduleItem)
                    }
                }
                .frame(width: width, height: GetFrameHeight())
            }
        }
        else{
            EmptyView()
        }
    }
    func GetFrameHeight() -> CGFloat{
        return scheduleItem.GetBottomHeight() - scheduleItem.GetTopHeight()
    }
}

struct TagAndTaskView_VerticalLayout: View{
    @ObservedRealmObject var scheduleItem: ScheduleItem
    let taskTextPadding = DEVICE_WIDTH * 0.05
    var body: some View{
        if scheduleItem.isAlive{
            HStack{
                VStack(alignment: .leading){
                    ActivityTag(activity: scheduleItem.activity)
                    Spacer()
                    Text(scheduleItem.task.name)
                        .padding(.leading, taskTextPadding)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
struct TagAndTaskView_HorizontalLayout: View{
    @ObservedRealmObject var scheduleItem: ScheduleItem
    let taskTextPadding = DEVICE_WIDTH * 0.05
    var body: some View{
        if scheduleItem.isAlive{
            VStack{
                HStack(alignment: .top){
                    ActivityTag(activity: scheduleItem.activity)
                    Text(scheduleItem.task.name)
                        .padding(.leading, taskTextPadding)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct ActivityTag: View{
    @ObservedRealmObject var activity: Activity
    let cornerRadius = ScheduleItemViewSize.cornerRadius
    let color = Color(red: 207.0/255.0, green: 207.0/255.0, blue: 207.0/255.0).opacity(0.3)
    let height = DEVICE_HEIGHT * 0.03
    @State var width: CGFloat = 0
    var body: some View{
        ZStack{
            Rectangle()
                .fill(color)
                .frame(width: width, height: height)
                .roundTwoCorner(cornerRadius: cornerRadius)
            Text(activity.name)
                .background(GeometryReader { (geometryProxy : GeometryProxy) in
                    HStack {}
                        .padding()
                        .onAppear {
                            width = geometryProxy.size.width
                        }
                        .onChange(of: activity.name) { _ in
                            width = geometryProxy.size.width
                        }
                })
        }
    }
}

extension View{
    //左上と右下のみ丸める
    func roundTwoCorner(cornerRadius: CGFloat) -> some View{
        self.mask(PartlyRoundedCornerView(cornerRadius: cornerRadius, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner]))
    }
}

//角丸を各角にそれぞれ適用できる。UIKitをSwiftUIで使えるようにしてるらしい
struct PartlyRoundedCornerView: UIViewRepresentable {
    let cornerRadius: CGFloat
    let maskedCorners: CACornerMask

    func makeUIView(context: UIViewRepresentableContext<PartlyRoundedCornerView>) -> UIView {
        // 引数で受け取った値を利用して、一部の角のみを丸くしたViewを作成する
        let uiView = UIView()
        uiView.layer.cornerRadius = cornerRadius
        uiView.layer.maskedCorners = maskedCorners
        uiView.backgroundColor = .white
        return uiView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PartlyRoundedCornerView>) {
    }
}
