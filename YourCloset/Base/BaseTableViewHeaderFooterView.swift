//
//  BaseTableViewHeaderFooterView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/22.
//

import Foundation
import UIKit

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() { }
    
    func setConstraints() { }
}
