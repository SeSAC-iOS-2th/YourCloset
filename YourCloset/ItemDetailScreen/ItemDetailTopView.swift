//
//  ItemDetailTopView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/15.
//

import Foundation
import UIKit
import SnapKit

class ItemDetailTopView: BaseView {
    
    var categoryNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "하의"
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        return nameLabel
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        return button
    }()
    
    let addGroupButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "folder.fill.badge.plus"), for: .normal)
        return button
    }()
    
    let addItemButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    override func configure() {
        [categoryNameLabel, backButton, addGroupButton, addItemButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        categoryNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-15)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryNameLabel.snp.centerY)
            make.leading.equalTo(5)
            make.height.width.equalTo(50)
        }
        
        addGroupButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryNameLabel.snp.centerY)
            make.trailing.equalTo(-15)
            make.height.width.equalTo(30)
        }
        
        addItemButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryNameLabel.snp.centerY)
            make.trailing.equalTo(addGroupButton.snp.leading).offset(-15)
            make.height.width.equalTo(30)
        }
        
    }
    
}
