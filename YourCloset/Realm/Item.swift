//
//  ItemToBuy.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/18.
//

import Foundation
import RealmSwift
import UIKit

class Item: Object {
    @Persisted var category: String
    @Persisted var group: String?
    @Persisted var imageURL: String?
    @Persisted var name: String
    @Persisted var brand: String
    @Persisted var size: String
    @Persisted var purchasingStatus: Bool
    @Persisted var checkBoxStatus: Bool?
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(category: String, name: String, brand: String, size: String, purchasingStatus: Bool, checkBoxStatus: Bool) {
        self.init()
        self.category = category
        self.name = name
        self.brand = brand
        self.size = size
        self.purchasingStatus = purchasingStatus
        self.checkBoxStatus = checkBoxStatus
    }
    
    convenience init(category: String, group: String, imageURL: String, name: String, brand: String, size: String, purchasingStatus: Bool) {
        self.init()
        self.category = category
        self.imageURL = imageURL
        self.group = group
        self.name = name
        self.brand = brand
        self.size = size
        self.purchasingStatus = purchasingStatus
    }

}
