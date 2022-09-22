//
//  ListToBuyViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import SnapKit
import UIKit
import RealmSwift
import Toast


class ListToBuyViewController: BaseViewController {
    
    let itemRepo = ItemRepository()
    
    var outerItems: Results<Item>! {
        didSet {
            tableView.reloadData()
        }
    }
    var topItems: Results<Item>! {
        didSet {
            tableView.reloadData()
        }
    }
    var bottomItems: Results<Item>! {
        didSet {
            tableView.reloadData()
        }
    }
    var shoesItems: Results<Item>! {
        didSet {
            tableView.reloadData()
        }
    }
    var accessoriesItems: Results<Item>! {
        didSet {
            tableView.reloadData()
        }
    }

    
    let categoryNameArray = ["아우터", "상의", "하의", "신발", "악세서리"]
        
    lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        barButton.tintColor = .black
        return barButton
    }()
                    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    
    @objc func addButtonClicked() {
        let vc = StoreItemToBuyViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        print("Touch Button")
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListToBuyTableViewCell.self, forCellReuseIdentifier: "ListToBuyTableViewCell")
        
        navigationItem.title = "구매 예정 목록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        navigationItem.rightBarButtonItem = rightBarButton
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRepo()
    }
    
    func fetchRepo() {
        outerItems = itemRepo.fetchByCategory("아우터", false)
        topItems = itemRepo.fetchByCategory("상의", false)
        bottomItems = itemRepo.fetchByCategory("하의", false)
        shoesItems = itemRepo.fetchByCategory("신발", false)
        accessoriesItems = itemRepo.fetchByCategory("악세서리", false)
    }
        
    override func configure() {
        [tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    
}

extension ListToBuyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryNameArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryNameArray[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return outerItems?.count ?? 0
        case 1:
            return topItems?.count ?? 0
        case 2:
            return bottomItems?.count ?? 0
        case 3:
            return shoesItems?.count ?? 0
        case 4:
            return accessoriesItems?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListToBuyTableViewCell", for: indexPath) as? ListToBuyTableViewCell else { return UITableViewCell() }
                
        
        switch indexPath.section {
        case 0:
            cell.itemNameLabel.text = outerItems[indexPath.row].name
        case 1:
            cell.itemNameLabel.text = topItems[indexPath.row].name
        case 2:
            cell.itemNameLabel.text = bottomItems[indexPath.row].name
        case 3:
            cell.itemNameLabel.text = shoesItems[indexPath.row].name
        case 4:
            cell.itemNameLabel.text = accessoriesItems[indexPath.row].name
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            let alert = UIAlertController(title: "주의", message: "정말 아이템을 구매 예정 목록에서 삭제하시겠습니까?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "네", style: .default) { _ in
                var item: Item
                
                switch indexPath.section {
                case 0:
                    item = self.outerItems[indexPath.row]
                case 1:
                    item = self.topItems[indexPath.row]
                case 2:
                    item = self.bottomItems[indexPath.row]
                case 3:
                    item = self.shoesItems[indexPath.row]
                case 4:
                    item = self.accessoriesItems[indexPath.row]
                default:
                    item = Item()
                }
                
                self.itemRepo.deleteItem(item: item)
                self.fetchRepo()
                
                self.view.makeToast("삭제되었습니다.", duration: 1.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
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
        let currentCell = tableView.cellForRow(at: indexPath) as? ListToBuyTableViewCell
        
        if currentCell?.checkBoxButton.image(for: .normal) == UIImage(systemName: "checkmark.rectangle.fill") {
            let alert = UIAlertController(title: nil, message: "구매한 아이템을\n 내 옷장으로 이동하시겠습니까?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "네", style: .default) { _ in
                let item: Item
                
                switch indexPath.section {
                case 0:
                    item = Item(category: self.outerItems[indexPath.row].category, group: "Default", imageURL: "", name: self.outerItems[indexPath.row].name, brand: self.outerItems[indexPath.row].brand, size: self.outerItems[indexPath.row].size, purchasingStatus: true)
                    self.itemRepo.deleteItem(item: self.outerItems[indexPath.row])
                case 1:
                    item = Item(category: self.topItems[indexPath.row].category, group: "Default", imageURL: "", name: self.topItems[indexPath.row].name, brand: self.topItems[indexPath.row].brand, size: self.topItems[indexPath.row].size, purchasingStatus: true)
                    self.itemRepo.deleteItem(item: self.topItems[indexPath.row])
                case 2:
                    item = Item(category: self.bottomItems[indexPath.row].category, group: "Default", imageURL: "", name: self.bottomItems[indexPath.row].name, brand: self.bottomItems[indexPath.row].brand, size: self.bottomItems[indexPath.row].size, purchasingStatus: true)
                    self.itemRepo.deleteItem(item: self.bottomItems[indexPath.row])
                case 3:
                    item = Item(category: self.shoesItems[indexPath.row].category, group: "Default", imageURL: "", name: self.shoesItems[indexPath.row].name, brand: self.shoesItems[indexPath.row].brand, size: self.shoesItems[indexPath.row].size, purchasingStatus: true)
                    self.itemRepo.deleteItem(item: self.shoesItems[indexPath.row])
                case 4:
                    item = Item(category: self.accessoriesItems[indexPath.row].category, group: "Default", imageURL: "", name: self.accessoriesItems[indexPath.row].name, brand: self.accessoriesItems[indexPath.row].brand, size: self.accessoriesItems[indexPath.row].size, purchasingStatus: true)
                    self.itemRepo.deleteItem(item: self.accessoriesItems[indexPath.row])
                default:
                    item = Item()
                }
                
                self.itemRepo.createItem(item: item)
                
                self.view.makeToast("내 옷장으로 이동되었습니다.", duration: 1.0, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)
                
                tableView.reloadData()
            }
            
            let noAction = UIAlertAction(title: "아니오", style: .cancel)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: true)
        } else {
            currentCell?.selectionStyle = .none
        }
    }
        
            
}

