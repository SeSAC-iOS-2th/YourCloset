//
//  OpenSourceViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/24.
//

import Foundation
import UIKit
import SnapKit

class OpenSourceViewController: BaseViewController {
    
    let libraryArray = ["Realm", "SnapKit", "Toast", "YPImagePicker"]
    
    lazy var leftBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        barButton.tintColor = .black
        return barButton
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "오픈소스 라이브러리"
        navigationItem.leftBarButtonItem = leftBarButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OpenSourceTableViewCell.self, forCellReuseIdentifier: "OpenSourceTableViewCell")
    }
    
    override func configure() {
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
}

extension OpenSourceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OpenSourceTableViewCell", for: indexPath) as? OpenSourceTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.nameLabel.text = libraryArray[indexPath.row]
        
        return cell
    }
    
}
