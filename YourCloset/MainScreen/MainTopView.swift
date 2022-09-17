//
//  MainTopView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import UIKit
import SnapKit

class MainTopview: BaseView {
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "너의 옷장은"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "'고래밥'님"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func configure() {
        [appTitleLabel, userNameLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        appTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-15)
        }
        userNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(appTitleLabel.snp.bottom)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            
        }
    }
    
}
