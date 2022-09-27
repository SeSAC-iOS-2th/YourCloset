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
    
    lazy var leftBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClikced))
        barButton.tintColor = .black
        return barButton
    }()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(storeButtonClicked))
        barButton.tintColor = .black
        return barButton
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임: "
        return label
    }()
    
    lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "1~4글자 입력"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.delegate = self
        textField.becomeFirstResponder()
        return textField
    }()
    
    @objc func backButtonClikced() {
        dismiss(animated: true)
    }
        
    @objc func storeButtonClicked() {
        if let nickname = self.nicknameTextField.text, nickname.isEmpty {
            self.view.makeToast("입력값이 비어있습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "닉네임을 저장하시겠습니까?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "네", style: .default, handler: {_ in
                UserDefaults.standard.set(self.nicknameTextField.text, forKey: "nickname")
                self.view.makeToast("저장되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                
                self.nicknameTextField.resignFirstResponder()

            })
            let noAction = UIAlertAction(title: "아니오", style: .cancel)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedBackground()
        
        view.backgroundColor = UIColor.projectColor(.backgroundColor)
        
        navigationItem.title = "프로필"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func configure() {
        [nicknameLabel, nicknameTextField].forEach {
            view.addSubview($0)
        }
    }

    override func setConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.equalTo(50)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.top)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changeText = currentText.replacingCharacters(in: stringRange, with: string)
        return changeText.count <= 5
    }
}
