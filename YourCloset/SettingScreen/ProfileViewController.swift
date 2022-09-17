//
//  ProfileViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/16.
//

import Foundation
import UIKit
import SnapKit

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
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력하세요"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    @objc func backButtonClikced() {
        self.navigationController?.popViewController(animated: true)
    }
        
    @objc func storeButtonClicked() {
        let alert = UIAlertController(title: "저장", message: "수정 사항을 저장하시겠습니까?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "네", style: .default, handler: {_ in
            UserDefaults.standard.set(self.nicknameTextField.text, forKey: "nickname")
        })
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
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
