//
//  GroupByCategory.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/21.
//

import Foundation
import RealmSwift
import UIKit

class Group: Object {
    @Persisted var category: String
    @Persisted var group: String
    @Persisted var count: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(category: String, group: String, count: Int) {
        self.init()
        self.category = category
        self.group = group
        self.count = count
    }
}

