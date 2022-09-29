//
//  ItemDetailTableHeaderView2.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/29.
//

import Foundation
import UIKit
import SnapKit

class ItemDetailTableHeaderView2: BaseTableViewHeaderFooterView {
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
        
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override func configure() {
        [groupLabel, removeButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        groupLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(5)
        }
                
        removeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-10)
        }
    }
    
}
