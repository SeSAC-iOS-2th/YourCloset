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
    
    let addGroupView: AddGroupView = {
        let addGroupView = AddGroupView()
        addGroupView.backgroundColor = .white
        addGroupView.layer.cornerRadius = 8
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
        let group = Group(category: self.categoryInfo, group: self.addGroupView.inputTextField.text ?? "")
        
        
        let alert = UIAlertController(title: nil, message: "그룹을 추가하시겠습니까?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
            self.groupRepo.createItem(group: group)
            self.view.makeToast("저장되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            self.dismiss(animated: true)
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
    override func configure() {
        [addGroupView, xButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        addGroupView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.equalToSuperview().multipliedBy(0.75)
        }
        
        xButton.snp.makeConstraints { make in
            make.trailing.equalTo(addGroupView.snp.leading).offset(-10)
            make.bottom.equalTo(addGroupView.snp.top).offset(-10)
            make.height.width.equalTo(20)
        }
    }
    
}
