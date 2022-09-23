//
//  CheckBoxButton.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/24.
//

import Foundation
import UIKit

class CheckBoxButton: UIButton {
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemeted")
    }
}


