//
//  BaseView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemeted")
    }
    
    func configure() { }
    
    func setConstraints() { }
    
}
