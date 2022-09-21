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
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(category: String, group: String) {
        self.init()
        self.category = category
        self.group = group
    }
}

