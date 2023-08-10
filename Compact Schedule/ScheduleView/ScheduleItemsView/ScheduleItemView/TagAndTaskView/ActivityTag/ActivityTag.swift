//
//  ActivityTag.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/10.
//

import SwiftUI
import RealmSwift

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

//角丸を各角にそれぞれ適用できる。UIKitの機能をSwiftUIで使えるようにする
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
