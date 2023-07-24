//
//  Task.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

class Task: Object, Identifiable{
    @Persisted private var Name: String
    @Persisted var minutes: Int
    @Persisted(primaryKey: true) var id:String = UUID().uuidString
    var name: String{
        get{ return Name}
        set{
            DispatchQueue.main.async {
                try! realm_.write{
                    self.Name = newValue
                }
            }
        }
    }
    override init(){
        super.init()
    }
    init(name: String, minutes: Int){
        self.Name = name
        self.minutes = minutes
    }
    
}


//nameのsetクロージャについて
//そのまま書くとThread 1: "Cannot register notification blocks from within write transactions. が出てしまうため、mainキューに追加して実行している
//通知ブロックはrealm.add()などのRealmSwiftの関数のことで、これをwrite transaction(クロージャの中)に書くとダメというエラー。エラーが出るような書き方はしていないはずだが、ChatGPT曰くset内に更新処理を書くことでUIの描画処理と競合してバグが起きていると考えられるらしく、競合しないように書いてあげることでエラーは解決した。
