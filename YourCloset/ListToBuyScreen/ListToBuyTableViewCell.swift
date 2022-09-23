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
    
    lazy var checkBoxButton: CheckBoxButton = {
        let button = CheckBoxButton()
        button.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(checkBoxButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func checkBoxButtonClicked(_ checkBoxButton: UIButton) {
        var checkBoxImage = checkBoxButton.image(for: .normal)
        checkBoxImage = checkBoxImage == UIImage(systemName: "checkmark.rectangle") ? UIImage(systemName: "checkmark.rectangle.fill") : UIImage(systemName: "checkmark.rectangle")
        
        checkBoxButton.setImage(checkBoxImage, for: .normal)
    }
        
    override func configure() {
        [itemNameLabel, checkBoxButton].forEach {
            self.contentView.addSubview($0)
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

