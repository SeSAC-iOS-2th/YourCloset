//
//  AddItemTopView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/21.
//

import Foundation
import UIKit
import SnapKit

class AddItemTopView: BaseView {
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        return nameLabel
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let storeButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override func configure() {
        [nameLabel, backButton, storeButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-15)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.leading.equalTo(15)
        }
        
        storeButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalTo(-15)
        }
    }
    
}
