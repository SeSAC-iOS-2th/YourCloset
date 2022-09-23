//
//  ItemToBuyRepository.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/18.
//

import Foundation
import RealmSwift

class ItemRepository {
    
    let localRealm = try! Realm()
    
    func fetch() -> Results<Item> {
        return localRealm.objects(Item.self)
    }
    
    func fetchByCategory(_ categoryName: String, _ status: Bool) -> Results<Item> {
        return localRealm.objects(Item.self).filter("category == '\(categoryName)' && purchasingStatus == \(status)")
    }
        
    func fetchByGroup(_ categoryName: String, _ groupName: String) -> Results<Item> {
        return localRealm.objects(Item.self).filter("category == '\(categoryName)'&& group == '\(groupName)' && purchasingStatus == true")
    }
    
    func updateGroupOfItem(item: Item) {
        do {
            try localRealm.write {
                item.group = "Default"
            }
        } catch let error {
            print(error)
        }
    }
    
    func updateCheckBoxStatus(item: Item) {
        do {
            try localRealm.write {
                item.checkBoxStatus = !(item.checkBoxStatus ?? false)
            }
        } catch let error {
            print(error)
        }
    }
    
    func createItem(item: Item) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteItem(item: Item) {
        try! localRealm.write {
            localRealm.delete(item)
        }
    }
    
    func deleteAll() {
        try! localRealm.write {
            localRealm.deleteAll()
        }
    }
    
}
