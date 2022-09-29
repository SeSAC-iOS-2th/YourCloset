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
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let brandLabel: BrandAndSizeCustomLabel = {
        let label = BrandAndSizeCustomLabel()
        return label
    }()
    
    let sizeLabel: BrandAndSizeCustomLabel = {
        let label = BrandAndSizeCustomLabel()
        return label
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
    
    override var frame: CGRect {
        get {
            return super.frame
        } set(newFrame) {
            var frame = newFrame
            let newWidth = UIScreen.main.bounds.width * 0.92
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            super.frame = frame
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8
        self.layer.cornerRadius = 16
    }
        
    override func configure() {
        [itemNameLabel, brandLabel, sizeLabel, checkBoxButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.top.equalTo(10)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.leading.equalTo(itemNameLabel.snp.leading)
            make.top.equalTo(itemNameLabel.snp.bottom).offset(15)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.top)
            make.leading.equalTo(brandLabel.snp.trailing).offset(15)
        }
        
        checkBoxButton.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(self.frame.height * 0.75)
        }
    }
    
}

