//
//  ItemDetailPageViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/16.
//

import Foundation
import SnapKit
import UIKit

protocol SendDataDelegate: AnyObject {
    func sendModifyData(name: String, brand: String, size: String)
    func reload()
}

class ItemDetailPageViewController: BaseViewController, SendDataDelegate {
    
    var categoryInfo = ""
    
    lazy var itemDetailPageView: ItemDetailPageView = {
        let pageView = ItemDetailPageView()
        pageView.backgroundColor = .white
        pageView.modifyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
        return pageView
    }()
        
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        button.tintColor = .lightGray
        return button
    }()
    
    var transitionItem = Item()
    
    weak var delegate: reloadTableDelegate?
    
    @objc func modifyButtonClicked() {
        let vc = AddItemViewController()
        vc.delegate = self
        UserDefaults.standard.set("modify", forKey: "addOrModify")
        vc.beforeModifyInfo.append(contentsOf: [itemDetailPageView.itemNameInfoLabel.text!, itemDetailPageView.brandInfoLabel.text!, itemDetailPageView.sizeInfoLabel.text!])
        vc.categoryInfo = categoryInfo
        vc.modalPresentationStyle = .fullScreen
        vc.transitionItem = transitionItem
        present(vc, animated: true)
        
    }
    
    @objc func xButtonClicked() {
        self.delegate?.reload()
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
    
    func sendModifyData(name: String, brand: String, size: String) {
        self.itemDetailPageView.itemNameInfoLabel.text = name
        self.itemDetailPageView.brandInfoLabel.text = brand
        self.itemDetailPageView.sizeInfoLabel.text = size
    }
    
    func reload() {
        self.delegate?.reload()
    }
    
}

