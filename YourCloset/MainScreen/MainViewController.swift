//
//  MainViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/14.
//

import Foundation
import UIKit
import SnapKit

class MainViewController: BaseViewController {
    
    let mainTopView: MainTopview = {
        let mainTopView = MainTopview()
        mainTopView.backgroundColor = .orange
        return mainTopView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .purple
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func configure() {
        [mainTopView, tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        mainTopView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.height.equalTo(view.frame.height * 0.15)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(0)
            make.top.equalTo(mainTopView.snp.bottom)
            make.bottom.equalTo(50)
        }
    }
    
    
}
