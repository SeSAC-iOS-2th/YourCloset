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
    
    let itemToBuyRepo = ItemToBuyRepository()
    
    var allItems: Results<ItemToBuy>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var outerItems: Results<ItemToBuy>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var topItems: Results<ItemToBuy>! {
        didSet {
            tableView.reloadData()
        }
    }

    var bottomItems: Results<ItemToBuy>! {
        didSet {
            tableView.reloadData()
        }
    }

    var shoesItems: Results<ItemToBuy>! {
        didSet {
            tableView.reloadData()
        }
    }
        
    var accessoriesItems: Results<ItemToBuy>! {
        didSet {
            tableView.reloadData()
        }
    }

    
    let categoryNameArray = ["전체", "아우터", "상의", "하의", "신발", "악세서리"]
        
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
        allItems = itemToBuyRepo.fetch()
        outerItems = itemToBuyRepo.fetchByCategory("아우터")
        topItems = itemToBuyRepo.fetchByCategory("상의")
        bottomItems = itemToBuyRepo.fetchByCategory("하의")
        shoesItems = itemToBuyRepo.fetchByCategory("신발")
        accessoriesItems = itemToBuyRepo.fetchByCategory("악세서리")
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
            return allItems?.count ?? 0
        case 1:
            return outerItems?.count ?? 0
        case 2:
            return topItems?.count ?? 0
        case 3:
            return bottomItems?.count ?? 0
        case 4:
            return shoesItems?.count ?? 0
        case 5:
            return accessoriesItems?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListToBuyTableViewCell", for: indexPath) as? ListToBuyTableViewCell else { return UITableViewCell() }
        
        
        switch indexPath.section {
        case 0:
            cell.itemNameLabel.text = allItems[indexPath.row].name
        case 1:
            cell.itemNameLabel.text = outerItems[indexPath.row].name
        case 2:
            cell.itemNameLabel.text = topItems[indexPath.row].name
        case 3:
            cell.itemNameLabel.text = bottomItems[indexPath.row].name
        case 4:
            cell.itemNameLabel.text = shoesItems[indexPath.row].name
        case 5:
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
                var item: ItemToBuy
                
                switch indexPath.section {
                case 0:
                    item = self.allItems[indexPath.row]
                case 1:
                    item = self.outerItems[indexPath.row]
                case 2:
                    item = self.topItems[indexPath.row]
                case 3:
                    item = self.bottomItems[indexPath.row]
                case 4:
                    item = self.shoesItems[indexPath.row]
                case 5:
                    item = self.accessoriesItems[indexPath.row]
                default:
                    item = ItemToBuy()
                }
                
                self.itemToBuyRepo.deleteItem(item: item)
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
    
}

