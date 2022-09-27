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
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
        
    let itemNumLabel: UILabel = {
        let label = UILabel()
        label.text = "0개의 아이템"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Handle")
        imageView.tintColor = .black
        return imageView
    }()
    
    override var frame: CGRect {
        get {
            return super.frame
        } set(newFrame) {
            var frame = newFrame
            let newWidth = UIScreen.main.bounds.width * 0.9
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            super.frame = frame
        }
    }
    
    
    override func configure() {
        [categoryNameLabel, itemNumLabel, arrowImageView].forEach {
            self.addSubview($0)
        }
        
        layoutSubviews()
    }
    
    override func setConstraints() {
        categoryNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
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
