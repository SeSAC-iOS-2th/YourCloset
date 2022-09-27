//
//  AddGroupView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/20.
//

import Foundation
import SnapKit
import UIKit

class AddGroupView: BaseView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "그룹 추가"
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Group"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    override func configure() {
        [titleLabel, inputTextField, addButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
    }
    
}
