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
        
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름없음"
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let nimLabel: UILabel = {
        let label = UILabel()
        label.text = "님"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
//    let exitButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "power"), for: .normal)
//        button.tintColor = .red
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.red.cgColor
//        button.layer.cornerRadius = 12.5
//        return button
//    }()
    
    override func configure() {
        [appTitleLabel, userNameLabel, nimLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        appTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-15)
        }
        userNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(appTitleLabel)
            make.leading.equalTo(appTitleLabel.snp.trailing).offset(50)
        }
        nimLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userNameLabel)
            make.leading.equalTo(userNameLabel.snp.trailing)
            make.trailing.equalTo(-15)
        }
//        exitButton.snp.makeConstraints { make in
//            make.leading.equalTo(25)
//            make.bottom.equalTo(-15)
//            make.height.width.equalTo(25)
//        }
    }
    
}
