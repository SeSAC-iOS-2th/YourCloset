//
//  GroupListTableViewCell.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/29.
//

import Foundation
import UIKit
import SnapKit

class GroupListTableViewCell: BaseTableViewCell {
    
    let dotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .black
        return imageView
    }()
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    override func configure() {
        [dotImageView, groupLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        dotImageView.snp.makeConstraints { make in
            make.height.width.equalTo(5)
            make.centerY.equalToSuperview()
            make.leading.equalTo(20)
        }
        groupLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(dotImageView.snp.trailing).offset(10)
        }
    }
    
}
