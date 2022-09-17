//
//  ItemDetailViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/15.
//

import Foundation
import SnapKit
import UIKit

class ItemDetailViewController: BaseViewController {
    
    let groupArray = ["데님", "슬랙스"]
    
    let denimItemInfo = [
        ["Punk Town", "Mod9", "30", "스트레이트"],
        ["Old Buddy", "Mod9", "30", "와이트"],
        ["Sky High", "Mod9", "30", "와이트"]
    ]
    
    let slacksItemInfo = [
        ["그레이 슬랙스", "무00", "31", "세미와이드"],
        ["라이트베이즈 슬랙스", "인스펙터", "30", "와이드"]
    ]
    
    let itemDetailTopView: ItemDetailTopView = {
        let itemDetailTopView = ItemDetailTopView()
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
        itemDetailTopView.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)

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
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return denimItemInfo.count
        } else {
            return slacksItemInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupArray[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailTableViewCell", for: indexPath) as? ItemDetailTableViewCell else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            cell.itemNameLabel.text = denimItemInfo[indexPath.row][0]
        } else if indexPath.section == 1 {
            cell.itemNameLabel.text = slacksItemInfo[indexPath.row][0]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemDetailPageViewController()
        present(vc, animated: true)
    }
    
}
