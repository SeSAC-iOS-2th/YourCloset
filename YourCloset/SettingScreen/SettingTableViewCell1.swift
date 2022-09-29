//
//  SettingTableViewCell.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import SnapKit
import UIKit

class SettingTableViewCell: BaseTableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        return button
    }()
    
    override func configure() {
        [nameLabel, arrowButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(15)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalTo(-15)
            make.width.height.equalTo(self.frame.height * 0.6)
        }
    }
    
}
