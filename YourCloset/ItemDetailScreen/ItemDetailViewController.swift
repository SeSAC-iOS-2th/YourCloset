//
//  ItemDetailViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/15.
//

import Foundation
import SnapKit
import UIKit
import RealmSwift

class ItemDetailViewController: BaseViewController {
    
    let groupRepo = GroupRepository()
    let itemRepo = ItemRepository()
    
    var groupByCategory: Results<Group>! {
        didSet {
            tableView.reloadData()
        }
    }
    
            
    lazy var itemDetailTopView: ItemDetailTopView = {
        let itemDetailTopView = ItemDetailTopView()
        
        itemDetailTopView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        itemDetailTopView.addGroupButton.addTarget(self, action: #selector(addGroupButtonClicked), for: .touchUpInside)
        itemDetailTopView.addItemButton.addTarget(self, action: #selector(addItemButtonClicked), for: .touchUpInside)
        
        itemDetailTopView.backgroundColor = .white
        return itemDetailTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemDetailTableViewCell.self, forCellReuseIdentifier: "ItemDetailTableViewCell")
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupByCategory = groupRepo.fetchByCategory(itemDetailTopView.categoryNameLabel.text!)
        tableView.reloadData()
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addItemButtonClicked() {
        let vc = AddItemViewController()
        vc.categoryInfo = itemDetailTopView.categoryNameLabel.text ?? ""
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func addGroupButtonClicked() {
        let vc = AddGroupViewController()
        vc.categoryInfo = itemDetailTopView.categoryNameLabel.text ?? ""
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func configure() {
        [itemDetailTopView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemDetailTopView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.height.equalTo(view.frame.height * 0.12)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(itemDetailTopView.snp.bottom)
        }
    }
    
}

extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupByCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[section].category, groupByCategory[section].group)
        return itemsByGroup.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupByCategory[section].group
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[indexPath.section].category, groupByCategory[indexPath.section].group)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailTableViewCell", for: indexPath) as? ItemDetailTableViewCell else { return UITableViewCell() }
        
        cell.itemNameLabel.text = itemsByGroup[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[indexPath.section].category, groupByCategory[indexPath.section].group)
        
        let vc = ItemDetailPageViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.itemDetailPageView.itemNameLabel.text = "제품명: \(itemsByGroup[indexPath.row].name)"
        vc.itemDetailPageView.brandLabel.text = "브랜드: \(itemsByGroup[indexPath.row].brand)"
        vc.itemDetailPageView.sizeLabel.text = "사이즈: \(itemsByGroup[indexPath.row].size)"
        present(vc, animated: true)
    }
    
}
