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
        imageView.image = UIImage(systemName: "star.fill")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "제품명: Punk Town"
        return label
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "브랜드: Mod9"
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "사이즈: 30"
        return label
    }()
    
    let fitLabel: UILabel = {
        let label = UILabel()
        label.text = "핏: 세미 와이드"
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
        return button
    }()
    
    override func configure() {
        [itemImageView, itemNameLabel, brandLabel, sizeLabel, fitLabel, dividingLineView, modifyButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemImageView.snp.makeConstraints { make in
            itemImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(30)
                make.width.equalToSuperview().multipliedBy(0.75)
                make.height.equalToSuperview().multipliedBy(0.4)
            }
            
            itemNameLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(itemImageView.snp.width)
                make.top.equalTo(itemImageView.snp.bottom).offset(30)
            }
            
            brandLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(itemImageView.snp.width)
                make.top.equalTo(itemNameLabel.snp.bottom).offset(15)
            }
            
            sizeLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(itemImageView.snp.width)
                make.top.equalTo(brandLabel.snp.bottom).offset(15)
            }
            
            fitLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(itemImageView.snp.width)
                make.top.equalTo(sizeLabel.snp.bottom).offset(15)
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
