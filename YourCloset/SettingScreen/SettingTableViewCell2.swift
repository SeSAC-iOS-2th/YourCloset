//
//  SettingTableViewCell2.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/29.
//

import Foundation
import SnapKit
import UIKit

class SettingTableViewCell2: BaseTableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        return imageView
    }()
    
    override func configure() {
        [nameLabel, arrowImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(15)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalTo(-15)
            make.width.height.equalTo(self.frame.height * 0.4)
        }
    }
    
}
