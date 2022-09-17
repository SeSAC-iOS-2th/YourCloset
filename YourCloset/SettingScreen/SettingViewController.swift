//
//  SettingViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import SnapKit
import UIKit

class SettingViewController: BaseViewController {
    
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
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initAlert() {
        let alert = UIAlertController(title: "데이터 초기화", message: "모든 데이터가 초기화됩니다.\n 정말 초기화 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "네", style: .default)
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
}
