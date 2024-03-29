//
//  ItemDetailTableViewCell.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/16.
//

import Foundation
import UIKit
import SnapKit

class ItemDetailTableViewCell: BaseTableViewCell {
        
    let itemNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func configure() {
        [itemNameLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 8
    }
    
}
