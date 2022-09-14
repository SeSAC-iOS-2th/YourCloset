//
//  ListToBuyViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import SnapKit
import UIKit

class ListToBuyViewController: BaseViewController {
    
    let categoryNameArray = ["아우터", "상의", "하의", "신발", "악세서리"]
    
    let itemsArray = [
        ["더블 라이더 자켓", "오버핏 후드 집업", "발마칸 코트"],
        ["스트라이프 롱슬리브", "캐시미어 니트"],
        ["세미와이드 슬랙스", "스트레이트 흑청", "카고 바지"],
        ["에어포스", "독일군"],
        ["골드 링 귀걸이", "실버 반지"]
    ]
    
    let listToBuyTopView: ListToBuyTopView = {
        let listToBuyTopView = ListToBuyTopView()
        listToBuyTopView.backgroundColor = .white
        return listToBuyTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListToBuyTableViewCell.self, forCellReuseIdentifier: "ListToBuyTableViewCell")
    }
    
    override func configure() {
        [listToBuyTopView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        listToBuyTopView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.height.equalTo(view.frame.height * 0.12)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(0)
            make.top.equalTo(listToBuyTopView.snp.bottom)
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
        return itemsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListToBuyTableViewCell", for: indexPath) as? ListToBuyTableViewCell else { return UITableViewCell() }
        
        cell.itemNameLabel.text = itemsArray[indexPath.section][indexPath.row]
        
        return cell
    }
    
}
