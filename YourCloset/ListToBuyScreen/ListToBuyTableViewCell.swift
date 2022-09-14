//
//  ListToBuyTableViewCell.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/15.
//

import Foundation
import SnapKit
import UIKit

class ListToBuyTableViewCell: BaseTableViewCell {
    
    let itemNameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    let checkBoxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override func configure() {
        [itemNameLabel, checkBoxButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        checkBoxButton.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.centerY.equalTo(itemNameLabel.snp.centerY)
            make.height.width.equalTo(self.frame.height * 0.75)
        }
    }
    
}
