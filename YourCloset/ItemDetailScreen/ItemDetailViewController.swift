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

class ItemDetailViewController: BaseViewController, reloadTableDelegate, UIGestureRecognizerDelegate {
    
    let groupRepo = GroupRepository()
    let itemRepo = ItemRepository()
    
    var groupByCategory: Results<Group>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var itemsByCategory: Results<Item>! {
        didSet {
            self.noticeLabel.isHidden = itemsByCategory.count != 0 ? true : false
            self.chatImageView.isHidden = itemsByCategory.count != 0 ? true: false
        }
    }
    
    var categoryInfo = ""
                    
    lazy var itemDetailTopView: ItemDetailTopView = {
        let itemDetailTopView = ItemDetailTopView()
        
        itemDetailTopView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        itemDetailTopView.addGroupButton.addTarget(self, action: #selector(addGroupButtonClicked), for: .touchUpInside)
        itemDetailTopView.addItemButton.addTarget(self, action: #selector(addItemButtonClicked), for: .touchUpInside)
        
        itemDetailTopView.backgroundColor = .clear
        return itemDetailTopView
    }()
        
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.backgroundImageByCategory()
        return imageView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let chatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ChatImageRect")
        return imageView
    }()
    
    let noticeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "옷장에 아이템을 추가해보세요!"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemDetailTableViewCell.self, forCellReuseIdentifier: "ItemDetailTableViewCell")
        tableView.register(ItemDetailTableHeaderView1.self, forHeaderFooterViewReuseIdentifier: "ItemDetailTableHeaderView1")
        tableView.register(ItemDetailTableHeaderView2.self, forHeaderFooterViewReuseIdentifier: "ItemDetailTableHeaderView2")
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        groupByCategory = groupRepo.fetchByCategory(itemDetailTopView.categoryNameLabel.text!)
        itemsByCategory = itemRepo.fetchByCategory(self.categoryInfo, true)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
        [backgroundImageView, itemDetailTopView, tableView, chatImageView, noticeLabel].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemDetailTopView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.height.equalTo(view.frame.height * 0.12)
        }
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(itemDetailTopView.snp.bottom).offset(20)
        }
        chatImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-45)
            make.height.width.equalTo(100)
        }
        noticeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(100)
        }
    }
    
    func reload() {
        self.tableView.reloadData()
    }
    
    func backgroundImageByCategory() -> UIImage {
        switch categoryInfo {
        case "아우터" :
            return UIImage(named: "ClosetOfOuter")!
        case "상의" :
            return UIImage(named: "ClosetOfTop")!
        case "하의" :
            return UIImage(named: "ClosetOfBottom")!
        case "신발" :
            return UIImage(named: "ClosetOfShoes")!
        case "악세서리" :
            return UIImage(named: "ClosetOfAccessories")!
        default:
            return UIImage()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[section].category, groupByCategory[section].group)
        return itemsByGroup.count == 0 ? 0 : 30
    }
    
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ItemDetailTableHeaderView1") as? ItemDetailTableHeaderView1 else { return UIView() }
                            
            header.groupLabel.text = groupByCategory[section].group
            header.groupLabel.textColor = .black
            header.backgroundColor = .clear
                            
            return header
        } else {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ItemDetailTableHeaderView2") as? ItemDetailTableHeaderView2 else { return UIView() }
            
            header.backgroundColor = .clear
            
            header.groupLabel.text = groupByCategory[section].group
            header.groupLabel.textColor = .black
            header.removeButton.addTarget(self, action: #selector(showRemoveActionSheet(_:)), for: .touchUpInside)
            header.removeButton.tag = section
                        
            return header
        }
    }
    
    @objc func showRemoveActionSheet(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeGroupAction = UIAlertAction(title: "그룹 삭제", style: .default) { _ in
            let itemsByGroup = self.itemRepo.fetchByGroup(self.groupByCategory[sender.tag].category, self.groupByCategory[sender.tag].group)
            
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
            
            self.present(alert, animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheet.addAction(removeGroupAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true)
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
            
            self.itemsByCategory = self.itemRepo.fetchByCategory(self.categoryInfo, true)
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
        
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.backgroundColor = UIColor.projectColor(.backgroundColor)
        cell.backgroundColor = .clear
        
        cell.itemNameLabel.text = itemsByGroup[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let itemsByGroup = itemRepo.fetchByGroup(groupByCategory[indexPath.section].category, groupByCategory[indexPath.section].group)
        let group = groupRepo.fetchSpecificGroup(groupByCategory[indexPath.section].category, groupByCategory[indexPath.section].group)
        
        let remove = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            let alert = UIAlertController(title: nil, message: "아이템을 내 옷장에서 삭제하시겠습니까?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "네", style: .default) { _ in
                let item = itemsByGroup[indexPath.row]
                
                self.deleteImageFromDocumentDirectory(imageName: "\(item.objectId).png")
                self.itemRepo.deleteItem(item: item)
                
                self.view.makeToast("삭제되었습니다.", duration: 1.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                
                self.groupRepo.minusCount(group)
                
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
        vc.reloadDelegate = self
        vc.modalPresentationStyle = .overCurrentContext
        if let image = loadImageFromDocumentDirectory(imageName: "\(itemsByGroup[indexPath.row].objectId).png") {
            vc.itemDetailPageView.itemImageView.image = image
        } else {
            vc.itemDetailPageView.itemImageView.image = showCategoryImage()
            print("보여주기 id: \(itemsByGroup[indexPath.row].objectId)")
        }
        vc.itemDetailPageView.itemNameInfoLabel.text = itemsByGroup[indexPath.row].name
        vc.itemDetailPageView.brandInfoLabel.text = itemsByGroup[indexPath.row].brand
        vc.itemDetailPageView.sizeInfoLabel.text = itemsByGroup[indexPath.row].size
        vc.categoryInfo = groupByCategory[indexPath.section].category
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
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
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
