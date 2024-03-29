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


class ListToBuyViewController: BaseViewController, reloadTableDelegate {
    
    let itemRepo = ItemRepository()
    
    var allItems: Results<Item>! {
        didSet {
            self.nothingToBuyView.isHidden = allItems.count != 0 ? true : false
        }
    }
    
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
        
    let nothingToBuyView: NothingToBuyView = {
        let view = NothingToBuyView()
        view.backgroundColor = UIColor.projectColor(.backgroundColor)
        return view
    }()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        barButton.tintColor = .black
        return barButton
    }()
                    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.projectColor(.backgroundColor)
        return tableView
    }()

    
    @objc func addButtonClicked() {
        let vc = StoreItemToBuyViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.reloadDelegate = self
        present(vc, animated: true)
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListToBuyTableViewCell.self, forCellReuseIdentifier: "ListToBuyTableViewCell")
        
        view.backgroundColor = UIColor.projectColor(.backgroundColor)
        
        navigationItem.title = "구매 예정 목록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.barTintColor = .systemGray4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRepo()
    }
    
    func fetchRepo() {
        allItems = itemRepo.fetchToBuy()
        outerItems = itemRepo.fetchByCategory("아우터", false)
        topItems = itemRepo.fetchByCategory("상의", false)
        bottomItems = itemRepo.fetchByCategory("하의", false)
        shoesItems = itemRepo.fetchByCategory("신발", false)
        accessoriesItems = itemRepo.fetchByCategory("악세서리", false)
    }
    
    func reload() {
        self.fetchRepo()
    }
        
    override func configure() {
        [tableView, nothingToBuyView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        nothingToBuyView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListToBuyTableViewCell", for: indexPath) as? ListToBuyTableViewCell else { return UITableViewCell() }
        var checkBoxButtonImage: UIImage! = UIImage()
        cell.checkBoxButton.indexPath = indexPath
        
        cell.contentView.backgroundColor = .lightGray
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 1
        cell.backgroundColor = .clear
        
        switch indexPath.section {
        case 0:
            checkBoxButtonImage = (outerItems[indexPath.row].checkBoxStatus!) ? UIImage(systemName: "checkmark.rectangle.fill") : UIImage(systemName: "checkmark.rectangle")
            cell.itemNameLabel.text = outerItems[indexPath.row].name
            cell.brandLabel.text = outerItems[indexPath.row].brand
            cell.sizeLabel.text = outerItems[indexPath.row].size
        case 1:
            checkBoxButtonImage = (topItems[indexPath.row].checkBoxStatus!) ? UIImage(systemName: "checkmark.rectangle.fill") : UIImage(systemName: "checkmark.rectangle")
            cell.itemNameLabel.text = topItems[indexPath.row].name
            cell.brandLabel.text = topItems[indexPath.row].brand
            cell.sizeLabel.text = topItems[indexPath.row].size
        case 2:
            checkBoxButtonImage = (bottomItems[indexPath.row].checkBoxStatus!) ? UIImage(systemName: "checkmark.rectangle.fill") : UIImage(systemName: "checkmark.rectangle")
            cell.itemNameLabel.text = bottomItems[indexPath.row].name
            cell.brandLabel.text = bottomItems[indexPath.row].brand
            cell.sizeLabel.text = bottomItems[indexPath.row].size
        case 3:
            checkBoxButtonImage = (shoesItems[indexPath.row].checkBoxStatus!) ? UIImage(systemName: "checkmark.rectangle.fill") : UIImage(systemName: "checkmark.rectangle")
            cell.itemNameLabel.text = shoesItems[indexPath.row].name
            cell.brandLabel.text = shoesItems[indexPath.row].brand
            cell.sizeLabel.text = shoesItems[indexPath.row].size
        case 4:
            checkBoxButtonImage = (accessoriesItems[indexPath.row].checkBoxStatus!) ? UIImage(systemName: "checkmark.rectangle.fill") : UIImage(systemName: "checkmark.rectangle")
            cell.itemNameLabel.text = accessoriesItems[indexPath.row].name
            cell.brandLabel.text = accessoriesItems[indexPath.row].brand
            cell.sizeLabel.text = accessoriesItems[indexPath.row].size
        default:
            break
        }

        cell.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonClicked(_:)), for: .touchUpInside)
        cell.checkBoxButton.setImage(checkBoxButtonImage, for: .normal)
        
        return cell
    }
    
    @objc func checkBoxButtonClicked(_ checkBoxButton: CheckBoxButton) {
        
        var item = Item()
        
        switch checkBoxButton.indexPath!.section {
        case 0:
            item = self.outerItems[checkBoxButton.indexPath!.row]
            self.itemRepo.updateCheckBoxStatus(item: item)
        case 1:
            item = self.topItems[checkBoxButton.indexPath!.row]
            self.itemRepo.updateCheckBoxStatus(item: item)
        case 2:
            item = self.bottomItems[checkBoxButton.indexPath!.row]
            self.itemRepo.updateCheckBoxStatus(item: item)
        case 3:
            item = self.shoesItems[checkBoxButton.indexPath!.row]
            self.itemRepo.updateCheckBoxStatus(item: item)
        case 4:
            item = self.accessoriesItems[checkBoxButton.indexPath!.row]
            self.itemRepo.updateCheckBoxStatus(item: item)
        default:
            break
        }
        
        self.tableView.reloadData()
    }

    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let remove = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            let alert = UIAlertController(title: nil, message: "아이템을 구매 예정 목록에서 삭제하시겠습니까?", preferredStyle: .alert)
            
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
                
                self.fetchRepo()
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

