//
//  AddGroupViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/20.
//

import Foundation
import SnapKit
import UIKit
import Toast

class AddGroupViewController: BaseViewController {
    
    let groupRepo = GroupRepository()
    
    var categoryInfo = ""
    
    lazy var addGroupView: AddGroupView = {
        let addGroupView = AddGroupView()
        addGroupView.backgroundColor = UIColor.projectColor(.backgroundColor)
        addGroupView.layer.cornerRadius = 8
        addGroupView.inputTextField.becomeFirstResponder()
        addGroupView.showListButton.addTarget(self, action: #selector(showGroupListButtonClicked), for: .touchUpInside)
        return addGroupView
    }()
    
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        button.tintColor = .lightGray
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedBackground()
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        addGroupView.addButton.addTarget(self, action: #selector(addGroupCheckButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let vc = presentingViewController as? ItemDetailViewController {
            DispatchQueue.main.async {
                vc.tableView.reloadData()
            }
        }
    }
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addGroupCheckButtonClicked() {
        if let text = self.addGroupView.inputTextField.text, text.isEmpty {
            self.view.makeToast("입력값이 비어있습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        } else {
            if checkExistGroup(self.addGroupView.inputTextField.text) {
                self.view.makeToast("이미 존재하는 그룹입니다!", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            } else {
                let alert = UIAlertController(title: nil, message: "그룹을 추가하시겠습니까?", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "네", style: .default) { _ in
                    let group = Group(category: self.categoryInfo, group: self.addGroupView.inputTextField.text ?? "", count: 0)
                    self.groupRepo.createItem(group: group)
                    self.view.makeToast("저장되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                    self.dismiss(animated: true)
                }
                let noAction = UIAlertAction(title: "아니오", style: .cancel)
                
                alert.addAction(yesAction)
                alert.addAction(noAction)
                
                present(alert, animated: true)
            }
        }
    }
    
    @objc func showGroupListButtonClicked() {
        let vc = GroupListTableViewController()
        vc.categoryInfo = categoryInfo
        self.present(vc, animated: true)
    }
    
    func checkExistGroup(_ inputGroup: String!) -> Bool {
        let group = self.groupRepo.fetchByCategory(self.categoryInfo)
        
        for element in group {
            if inputGroup == element.group { return true }
        }
        
        return false
    }
    
    override func configure() {
        [addGroupView, xButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        addGroupView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        
        xButton.snp.makeConstraints { make in
            make.trailing.equalTo(addGroupView.snp.leading).offset(-10)
            make.bottom.equalTo(addGroupView.snp.top).offset(-10)
            make.height.width.equalTo(20)
        }
    }
    
}
