//
//  StoreItemTableViewCell1.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/19.
//

import Foundation
import SnapKit
import UIKit

class StoreItemTableViewCell1: BaseTableViewCell {
    
    let infoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
        
    let dropDownView: DropDownView = {
        let dropDownView = DropDownView()
        return dropDownView
    }()
    
    override func configure() {
        [infoLabel, dropDownView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    
    override func setConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.leading.equalTo(20)
        }
        
        dropDownView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(infoLabel.snp.trailing).offset(20)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
        }
    }
    
}
