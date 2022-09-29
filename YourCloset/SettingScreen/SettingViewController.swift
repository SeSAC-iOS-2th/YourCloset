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
    
    let settingArray = ["닉네임", "백업/복구", "초기화", "오픈소스 라이브러리", "버전 정보"]
    
    let settingTopView: SettingTopView = {
        let settingTopView = SettingTopView()
        settingTopView.backgroundColor = UIColor.projectColor(.backgroundColor)
        return settingTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.projectColor(.backgroundColor)
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
        return settingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel.text = settingArray[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.projectColor(.backgroundColor)
        
        if indexPath.row == 1 || indexPath.row == 3 {
            cell.arrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        }
        if indexPath.row == 4 {
            cell.arrowButton.setTitle("1.0", for: .normal)
            cell.arrowButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            showProfile()
        case 1:
            print("2번째 셀 클릭")
        case 2:
            dataInitAlert()
        case 3:
            showOpenSource()
        case 4:
            print("5번째 셀 클릭")
        default:
            print("디폴트")
        }

    }
    
    func showProfile() {
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func dataInitAlert() {
        let alert = UIAlertController(title: "주의", message: "모든 데이터가 초기화됩니다.\n 정말 초기화 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
            for element in self.itemRepo.fetch() {
                self.deleteImageFromDocumentDirectory(imageName: "\(element.objectId).png")
            }
            self.groupRepo.deleteAll()
            self.itemRepo.deleteAll()
            
            UserDefaults.standard.removeObject(forKey: "nickname")
//            UserDefaults.standard.set("이름없음~!@#$%", forKey: "nickname")
            
            self.view.makeToast("초기화되었습니다.", duration: 2.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }
    
    func showOpenSource() {
        let vc = OpenSourceViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제하지 못함")
            }
        }
    }
    
}
