//
//  BrandAndSizeCustomLabel.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/25.
//

import Foundation
import UIKit

class BrandAndSizeCustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemeted")
    }
    
    func configure() {
        font = UIFont.systemFont(ofSize: 14)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        textAlignment = .center
    }
}
