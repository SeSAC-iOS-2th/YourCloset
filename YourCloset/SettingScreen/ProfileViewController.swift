//
//  ProfileViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/16.
//

import Foundation
import UIKit
import SnapKit
import Toast

class ProfileViewController: BaseViewController {
    
    let profileView: ProfileView = {
        let profileView = ProfileView()
        profileView.backgroundColor = UIColor.projectColor(.backgroundColor)
        profileView.layer.cornerRadius = 8
        profileView.inputTextField.becomeFirstResponder()
        return profileView
    }()
    
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        button.tintColor = .lightGray
        return button
    }()
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }

    @objc func storeButtonClicked() {
        if let nickname = self.profileView.inputTextField.text, nickname.isEmpty {
            self.view.makeToast("입력값이 비어있습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            if self.profileView.inputTextField.text == UserDefaults.standard.string(forKey: "nickname") {
                self.view.makeToast("중복된 닉네임입니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            } else {
                let alert = UIAlertController(title: nil, message: "닉네임을 저장하시겠습니까?", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "네", style: .default, handler: {_ in
                    UserDefaults.standard.set(self.profileView.inputTextField.text, forKey: "nickname")
                    self.view.makeToast("저장되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.dismiss(animated: true)
                    })
                })
                let noAction = UIAlertAction(title: "아니오", style: .cancel)

                alert.addAction(yesAction)
                alert.addAction(noAction)

                self.present(alert, animated: true)
            }
        }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        hideKeyboardWhenTappedBackground()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.profileView.inputTextField.delegate = self
        self.profileView.storeButton.addTarget(self, action: #selector(storeButtonClicked), for: .touchUpInside)
    }
    
    override func configure() {
        [profileView, xButton].forEach {
            view.addSubview($0)
        }
    }

    override func setConstraints() {
        profileView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        
        xButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileView.snp.leading).offset(-10)
            make.bottom.equalTo(profileView.snp.top).offset(-10)
            make.height.width.equalTo(20)
        }    }
    
}

extension ProfileViewController: UITextFieldDelegate {
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changeText = currentText.replacingCharacters(in: stringRange, with: string)
        return changeText.count <= 5
    }
}
