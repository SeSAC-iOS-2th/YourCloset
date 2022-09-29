////
////  GroupListTableView.swift
////  YourCloset
////
////  Created by 이중원 on 2022/09/29.
////

import Foundation
import UIKit
import SnapKit
import RealmSwift

class GroupListTableViewController: BaseViewController {

    let groupRepo = GroupRepository()
    
    var groupByCategory: Results<Group>!
        
    var categoryInfo = ""
    
    let groupListView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.projectColor(.backgroundColor)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "그룹 목록"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.projectColor(.itemColor)
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.projectColor(.backgroundColor)
        tableView.layer.cornerRadius = 8
        return tableView
    }()
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(GroupListTableViewCell.self, forCellReuseIdentifier: "GroupListTableViewCell")
        
        groupByCategory = groupRepo.fetchByCategory(self.categoryInfo)
    }

    override func configure() {
        [groupListView, titleLabel, backButton, tableView].forEach {
            view.addSubview($0)
        }
    }

    override func setConstraints() {
        groupListView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(groupListView).offset(15)
        }
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(groupListView).offset(15)
            //make.height.width.equalTo(30)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(groupListView)
        }
    }


}

extension GroupListTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupByCategory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupListTableViewCell", for: indexPath) as? GroupListTableViewCell else { return UITableViewCell() }
        
        cell.groupLabel.text = groupByCategory[indexPath.row].group
        cell.backgroundColor = UIColor.projectColor(.backgroundColor)
        
        return cell
    }

}
