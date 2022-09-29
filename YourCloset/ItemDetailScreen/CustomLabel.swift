//
//  CustomLabel.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/29.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = UIColor.projectColor(.itemColor)
        font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemeted")
    }
}
