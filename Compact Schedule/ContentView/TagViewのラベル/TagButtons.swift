//
//  TagButtons.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/08/09.
//

import SwiftUI

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
