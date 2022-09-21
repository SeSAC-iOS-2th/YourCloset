//
//  ItemDetailPageViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/16.
//

import Foundation
import SnapKit
import UIKit

class ItemDetailPageViewController: BaseViewController {
    
    let itemDetailPageView: ItemDetailPageView = {
        let pageView = ItemDetailPageView()
        pageView.backgroundColor = .white
        return pageView
    }()
    
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        button.tintColor = .lightGray
        return button
    }()
    
    @objc func xButtonClicked() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    override func configure() {
        [itemDetailPageView, xButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemDetailPageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(view.frame.height * 0.5)
            make.width.equalTo(view.frame.width * 0.75)
        }
        
        xButton.snp.makeConstraints { make in
            make.trailing.equalTo(itemDetailPageView.snp.leading).offset(-10)
            make.bottom.equalTo(itemDetailPageView.snp.top).offset(-10)
            make.height.width.equalTo(20)
        }
    }
    
}
