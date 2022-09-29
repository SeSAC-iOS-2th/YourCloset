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
        mainTopView.backgroundColor = UIColor.projectColor(.backgroundColor)
        return mainTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            mainTopView.appTitleLabel.text = "\(nickname)님의 옷장"
        } else {
            mainTopView.appTitleLabel.text = "너의 옷장은"
        }
        
        setDefaultGroup()
        
        tableView.reloadData()
        
    }
    
    func setDefaultGroup() {
        if groupRepo.fetch().count == 0 {
            groupRepo.createItem(group: Group(category: "아우터", group: "Default", count: 100))
            groupRepo.createItem(group: Group(category: "상의", group: "Default", count: 100))
            groupRepo.createItem(group: Group(category: "하의", group: "Default", count: 100))
            groupRepo.createItem(group: Group(category: "신발", group: "Default", count: 100))
            groupRepo.createItem(group: Group(category: "악세서리", group: "Default", count: 100))
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
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.projectColor(.closetEdgeColor).cgColor
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.projectColor(.closetColor)
        
        cell.selectionStyle = .none
        cell.itemNumLabel.text = "\(myItemByCategory.count)개의 아이템"
        cell.categoryNameLabel.text = categoryNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        vc.itemDetailTopView.categoryNameLabel.text = categoryNameArray[indexPath.row]
        vc.categoryInfo = categoryNameArray[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true)
    }
    
    
}
