//
//  Activity.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI
import RealmSwift

class Activity: Object, Identifiable{
    @Persisted var name: String
    @Persisted private var activityColor: ActivityColor?
    @Persisted var tasks = RealmSwift.List<Task>()
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    var color: Color{
        get{ return (activityColor?.color)!}
    }
    override init(){
        super.init()
    }
    init(name: String, activityColor: ActivityColor){
        self.name = name
        self.activityColor = activityColor
    }
    func AddTask(_ task: Task){
        try! realm_.write {
            tasks.append(task)
        }
    }
    //frozen対策
    func Copy() -> Activity{
        return self//Activity.Get(id: self.id)!
    }
}

extension Activity{
    static func loadAll() -> Results<Activity>{
        return realm_.objects(Activity.self)
    }
    static func Add(_ activity: Activity){
        try! realm_.write {
            realm_.add(activity)
        }
    }
    static func Delete(_ activity: Activity){
        try! realm_.write {
            realm_.delete(activity)
        }
    }
    static func Get(id: String) -> Activity?{
        let activity = realm_.object(ofType: Activity.self, forPrimaryKey: id)
        if let activity = activity{
            return activity
        }
        else{
            print("activityのidが無効です")
            return nil
        }
    }
}
