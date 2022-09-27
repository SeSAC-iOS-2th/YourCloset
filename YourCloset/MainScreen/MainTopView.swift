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
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
        
    override func configure() {
        self.addSubview(appTitleLabel)
    }
    
    override func setConstraints() {
        appTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-15)
        }
    }
}
