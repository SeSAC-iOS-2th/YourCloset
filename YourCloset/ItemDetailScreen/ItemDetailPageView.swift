//
//  ItemDetailView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/16.
//

import Foundation
import UIKit

class ItemDetailPageView: BaseView {
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    let itemNameLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "제품명: "
        return label
    }()
    let itemNameInfoLabel: CustomLabel = {
        let label = CustomLabel()
        return label
    }()
    
    let brandLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "브랜드: "
        return label
    }()
    let brandInfoLabel: CustomLabel = {
        let label = CustomLabel()
        return label
    }()

    let sizeLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "사이즈: "
        return label
    }()
    let sizeInfoLabel: CustomLabel = {
        let label = CustomLabel()
        return label
    }()
        
    let dividingLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.tintColor = .black
        return view
    }()
    
    let modifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("정보 수정하기", for: .normal)
        button.setTitleColor(UIColor.projectColor(.closetEdgeColor), for: .normal)
        return button
    }()
    
    override func configure() {
        [itemImageView, itemNameLabel, itemNameInfoLabel, brandLabel, brandInfoLabel, sizeLabel, sizeInfoLabel, dividingLineView, modifyButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemImageView.snp.makeConstraints { make in
            itemImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(30)
                make.width.height.equalTo(250)
            }
            
            itemNameLabel.snp.makeConstraints { make in
                make.leading.equalTo(itemImageView)
                make.top.equalTo(itemImageView.snp.bottom).offset(30)
            }
            
            itemNameInfoLabel.snp.makeConstraints { make in
                make.leading.equalTo(itemNameLabel.snp.trailing)
                make.width.equalTo(200)
                make.top.equalTo(itemNameLabel)
            }
            
            brandLabel.snp.makeConstraints { make in
                make.leading.equalTo(itemImageView)
                make.top.equalTo(itemNameLabel.snp.bottom).offset(15)
            }
            
            brandInfoLabel.snp.makeConstraints { make in
                make.leading.equalTo(brandLabel.snp.trailing)
                make.top.equalTo(brandLabel)
            }
            
            sizeLabel.snp.makeConstraints { make in
                make.leading.equalTo(itemImageView)
                make.top.equalTo(brandLabel.snp.bottom).offset(15)
            }
            
            sizeInfoLabel.snp.makeConstraints { make in
                make.leading.equalTo(sizeLabel.snp.trailing)
                make.top.equalTo(sizeLabel)
            }
                                    
            modifyButton.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalTo(0)
                make.height.equalToSuperview().multipliedBy(0.1)
            }
            
            dividingLineView.snp.makeConstraints { make in
                make.leading.trailing.equalTo(0)
                make.height.equalTo(1)
                make.bottom.equalTo(modifyButton.snp.top)
            }

        }
    }
}
