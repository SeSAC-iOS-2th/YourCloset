//
//  ItemDetailTableHeaderView1.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/24.
//

import Foundation
import UIKit
import SnapKit

class ItemDetailTableHeaderView1: BaseTableViewHeaderFooterView {
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func configure() {
        self.addSubview(groupLabel)
    }
    
    override func setConstraints() {
        groupLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(15)
        }
    }

}
