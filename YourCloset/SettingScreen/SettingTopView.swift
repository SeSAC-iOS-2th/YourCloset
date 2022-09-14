//
//  SettingTopView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import SnapKit
import UIKit

class SettingTopView: BaseView {
    
    let settingNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "설정"
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        return nameLabel
    }()
    
    override func configure() {
        self.addSubview(settingNameLabel)
    }
    
    override func setConstraints() {
        settingNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-15)
        }
    }
    
}
