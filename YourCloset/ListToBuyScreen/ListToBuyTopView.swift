//
//  ListToBuyTopView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/15.
//

import Foundation
import SnapKit
import UIKit

class ListToBuyTopView: BaseView {
    
    let listToBuyNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "구매 예정 목록"
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        return nameLabel
    }()
    
    let addItemButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    override func configure() {
        [listToBuyNameLabel, addItemButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        listToBuyNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-15)
        }
        
        addItemButton.snp.makeConstraints { make in
            make.centerY.equalTo(listToBuyNameLabel.snp.centerY)
            make.trailing.equalTo(-15)
            //make.height.width.equalTo(self.frame.height * 0.75)
        }
    }
    
}
