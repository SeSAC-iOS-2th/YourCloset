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
import Toast

protocol reloadTableDelegate: AnyObject {
    func reload()
}

class ItemDetailViewController: BaseViewController, reloadTableDelegate {
    
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
        tableView.register(ItemDetailTableHeaderView1.self, forHeaderFooterViewReuseIdentifier: "ItemDetailTableHeaderView1")
        tableView.register(ItemDetailTableHeaderView2.self, forHeaderFooterViewReuseIdentifier: "ItemDetailTableHeaderView2")
        
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
        UserDefaults.standard.set("add", forKey: "addOrModify")
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
    
    func reload() {
        self.tableView.reloadData()
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
    
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ItemDetailTableHeaderView1") as? ItemDetailTableHeaderView1 else { return UIView() }
                            
            header.groupLabel.text = groupByCategory[section].group
                            
            return header
        } else {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ItemDetailTableHeaderView2") as? ItemDetailTableHeaderView2 else { return UIView() }
                            
            header.groupLabel.text = groupByCategory[section].group
            header.removeButton.addTarget(self, action: #selector(removeButtonClicked(_:)), for: .touchUpInside)
            header.removeButton.tag = section
                            
            return header
        }
    }
    
    @objc func removeButtonClicked(_ sender: UIButton) {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[sender.tag].category, groupByCategory[sender.tag].group)
        
        let alert = UIAlertController(title: nil, message: "그룹을 삭제하시겠습니까?\n 해당 그룹의 아이템은 Default 그룹으로 옮겨집니다.", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
            for item in itemsByGroup {
                self.itemRepo.updateGroupOfItem(item: item)
            }
            
            let group = self.groupByCategory[sender.tag]
            self.groupRepo.deleteItem(group: group)
            
            self.view.makeToast("삭제되었습니다.", duration: 1.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
            
            self.tableView.reloadData()
        }
        
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        present(alert, animated: true)
    }

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[indexPath.section].category, groupByCategory[indexPath.section].group)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailTableViewCell", for: indexPath) as? ItemDetailTableViewCell else { return UITableViewCell() }
        
        cell.itemNameLabel.text = itemsByGroup[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[indexPath.section].category, groupByCategory[indexPath.section].group)
        
        let remove = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            let alert = UIAlertController(title: nil, message: "아이템을 내 옷장에서 삭제하시겠습니까?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "네", style: .default) { _ in
                let item = itemsByGroup[indexPath.row]
                
                self.itemRepo.deleteItem(item: item)
                
                self.view.makeToast("삭제되었습니다.", duration: 1.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                
                self.tableView.reloadData()
            }
            
            let noAction = UIAlertAction(title: "아니오", style: .cancel)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            self.present(alert, animated: true)
        }
        
        remove.image = UIImage(systemName: "trash.fill")
        remove.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [remove])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[indexPath.section].category, groupByCategory[indexPath.section].group)
        
        let vc = ItemDetailPageViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.itemDetailPageView.itemImageView.image = showCategoryImage()
        vc.itemDetailPageView.itemNameInfoLabel.text = itemsByGroup[indexPath.row].name
        vc.itemDetailPageView.brandInfoLabel.text = itemsByGroup[indexPath.row].brand
        vc.itemDetailPageView.sizeInfoLabel.text = itemsByGroup[indexPath.row].size
        vc.categoryInfo = groupByCategory[indexPath.row].category
        vc.transitionItem = itemsByGroup[indexPath.row]
        present(vc, animated: true)
    }
    
    func showCategoryImage() -> UIImage {
        switch itemDetailTopView.categoryNameLabel.text {
        case "아우터":
            return UIImage(named: "Jacket")!
        case "상의":
            return UIImage(named: "T-Shirt")!
        case "하의":
            return UIImage(named: "Pants")!
        case "신발":
            return UIImage(named: "Shoes")!
        case "악세서리":
            return UIImage(named: "Ring")!
        default:
            return UIImage()
        }
    }
        
}
