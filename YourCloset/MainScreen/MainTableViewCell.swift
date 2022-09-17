//
//  MainTableViewCell.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import SnapKit
import UIKit

class MainTableViewCell: BaseTableViewCell {
    
    let categoryNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        return nameLabel
    }()
    
    let itemNumLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.text = "0개의 아이템"
        numLabel.font = UIFont.systemFont(ofSize: 10)
        return numLabel
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.right.fill")
        imageView.tintColor = .black
        return imageView
    }()
    
    
    override func configure() {
        [categoryNameLabel, itemNumLabel, arrowImageView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        categoryNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(15)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(categoryNameLabel.snp.centerY)
            make.trailing.equalTo(-15)
            make.width.height.equalTo(self.frame.height * 0.5)
        }
        
        itemNumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryNameLabel.snp.centerY)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-8)
        }
    }
}
