//
//  GroupRepository.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/21.
//

import Foundation
import RealmSwift

class GroupRepository {
    
    let localRealm = try! Realm()

//    do {
//        let localRealm = try Realm()
//    } catch error {
//        print(Error)
//    }
    
    func fetch() -> Results<Group> {
        return localRealm.objects(Group.self)
    }
    
    func fetchByCategory(_ categoryName: String) -> Results<Group> {
        return localRealm.objects(Group.self).filter("category == '\(categoryName)'").sorted(byKeyPath: "count", ascending: false)
    }
    
    func fetchSpecificGroup(_ categoryName: String, _ groupName: String) -> Group {
        let group = localRealm.objects(Group.self).filter("category == '\(categoryName)' && group == '\(groupName)'")
        return group[0]
    }
    
    func plusCount(_ group: Group) {
        do {
            try localRealm.write {
                group.count += 1
            }
        } catch let error {
            print(error)
        }
    }
    
    func minusCount(_ group: Group) {
        do {
            try localRealm.write {
                group.count -= 1
            }
        } catch let error {
            print(error)
        }
    }

    
    func createItem(group: Group) {
        do {
            try localRealm.write {
                localRealm.add(group)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteItem(group: Group) {
        try! localRealm.write {
            localRealm.delete(group)
        }
    }
    
    func deleteAll() {
        try! localRealm.write {
            localRealm.deleteAll()
        }
    }

}
