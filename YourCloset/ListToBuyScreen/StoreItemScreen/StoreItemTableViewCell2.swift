//
//  StoreItemTableViewCell.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/19.
//

import Foundation
import SnapKit
import UIKit

class StoreItemTableViewCell2: BaseTableViewCell {
    
    let infoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let infoTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    override func configure() {
        [infoLabel, infoTextField].forEach {
            self.contentView.addSubview($0)
        }
    }
        
    override func setConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.leading.equalTo(20)
        }
        
        infoTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(infoLabel.snp.trailing).offset(20)
        }
    }
    
}
