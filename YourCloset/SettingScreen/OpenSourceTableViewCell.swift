//
//  OpenSourceTableViewCell.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/24.
//

import Foundation
import UIKit
import SnapKit

class OpenSourceTableViewCell: BaseTableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func configure() {
        self.addSubview(nameLabel)
    }
    
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(15)
        }
    }
    
    
}
