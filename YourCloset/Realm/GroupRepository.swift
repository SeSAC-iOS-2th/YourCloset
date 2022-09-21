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
    
    func fetch() -> Results<Group> {
        return localRealm.objects(Group.self)
    }
    
    func fetchByCategory(_ categoryName: String) -> Results<Group> {
        return localRealm.objects(Group.self).filter("category == '\(categoryName)'")
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
