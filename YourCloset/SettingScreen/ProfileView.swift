//
//  ProfileView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/29.
//

import Foundation
import UIKit
import SnapKit

class ProfileView: BaseView {
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "1~4글자 입력"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    let storeButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    override func configure() {
        [profileLabel, inputTextField, storeButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        profileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        inputTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileLabel.snp.bottom).offset(15)
        }
        storeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
    }
    
}
