//
//  SettingViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import SnapKit
import UIKit
import Toast

class SettingViewController: BaseViewController {
    
    let groupRepo = GroupRepository()
    let itemRepo = ItemRepository()
    
    let settingNameArray = ["프로필", "백업/복구", "초기화"]
    
    let settingTopView: SettingTopView = {
        let settingTopView = SettingTopView()
        settingTopView.backgroundColor = .white
        return settingTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
    }
    
    override func configure() {
        [settingTopView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        settingTopView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.height.equalTo(view.frame.height * 0.12)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(settingTopView.snp.bottom)
        }
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel.text = settingNameArray[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("0번째 셀 클릭")
            showProfile()
        case 1:
            print("1번째 셀 클릭")
        case 2:
            initAlert()
        default:
            print("디폴트")
        }
    }
    
    func showProfile() {
        let vc = ProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func initAlert() {
        let alert = UIAlertController(title: "주의", message: "모든 데이터가 초기화됩니다.\n 정말 초기화 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
            self.groupRepo.deleteAll()
            self.itemRepo.deleteAll()
            UserDefaults.standard.removeObject(forKey: "nickname")
            
            self.view.makeToast("초기화되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
}
