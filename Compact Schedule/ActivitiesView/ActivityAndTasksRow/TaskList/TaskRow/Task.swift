//
//  Task.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

@objcMembers
class Task: Object, Identifiable{
    @Persisted var name: String
    @Persisted var minutes: Int
    @Persisted(primaryKey: true) var id:String = UUID().uuidString
    override init(){
        super.init()
    }
    init(name: String, minutes: Int){
        self.name = name
        self.minutes = minutes
    }
}

extension Task{
    static func Get(id: String) -> Task?{
        let task = realm_.object(ofType: Task.self, forPrimaryKey: id)
        if let task = task{
            return task
        }
        else{
            print("taskのidが無効です")
            return nil
        }
    }
    static func Delete(_ task: Task){
        try! realm_.write {
            realm_.delete(task)
        }
    }
}


//nameのsetクロージャについて
//そのまま書くとThread 1: "Cannot register notification blocks from within write transactions. が出てしまうため、mainキューに追加して実行している
//エラーが出るような書き方はしていないはずだが、ChatGPT曰くset内に更新処理を書くことでUIの描画処理と競合してバグが起きていると考えられるらしく、競合しないように書いてあげることでエラーは解決した。
