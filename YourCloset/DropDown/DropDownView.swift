//
//  DropDownView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/19.
//

import Foundation
import UIKit
import SnapKit

class DropDownView: BaseView {

    let dropTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        return textField
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let selectButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func configure() {
        [dropTextField, iconImageView, selectButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(self.snp.height).multipliedBy(0.3)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-15)
        }
        
        dropTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(10)
            make.trailing.equalTo(iconImageView.snp.leading).offset(-5)
        }
        
        selectButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

