//
//  MainViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: BaseViewController {
        
    let categoryNameArray = ["아우터", "상의", "하의", "신발", "악세서리"]
    
    let groupRepo = GroupRepository()
    let itemRepo = ItemRepository()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FrontOfCloset")
        return imageView
    }()
    
    lazy var mainTopView: MainTopview = {
        let mainTopView = MainTopview()
        mainTopView.backgroundColor = .white
        return mainTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
//    @objc func exitButtonClicked() {
//        let alert = UIAlertController(title: nil, message: "앱을 종료하시겠습니까?", preferredStyle: .alert)
//
//        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
//            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                exit(0)
//            }
//        }
//        let noAction = UIAlertAction(title: "아니오", style: .cancel)
//
//        alert.addAction(yesAction)
//        alert.addAction(noAction)
//
//        present(alert, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            mainTopView.userNameLabel.text = nickname
        }
        
        setDefaultGroup()
        
        tableView.reloadData()
        
    }
    
    func setDefaultGroup() {
        if groupRepo.fetch().count == 0 {
            groupRepo.createItem(group: Group(category: "아우터", group: "Default"))
            groupRepo.createItem(group: Group(category: "상의", group: "Default"))
            groupRepo.createItem(group: Group(category: "하의", group: "Default"))
            groupRepo.createItem(group: Group(category: "신발", group: "Default"))
            groupRepo.createItem(group: Group(category: "악세서리", group: "Default"))
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    override func configure() {
        [backgroundImageView, mainTopView, tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        mainTopView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.height.equalToSuperview().multipliedBy(0.12)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(mainTopView.snp.bottom).offset(self.view.frame.height * 0.05)
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myItemByCategory = itemRepo.fetchByCategory(categoryNameArray[indexPath.row], true)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 8
        
        cell.selectionStyle = .none
        cell.itemNumLabel.text = "\(myItemByCategory.count)개의 아이템"
        cell.categoryNameLabel.text = categoryNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        vc.itemDetailTopView.categoryNameLabel.text = categoryNameArray[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
