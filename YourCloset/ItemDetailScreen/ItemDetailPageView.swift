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
        label.text = "제품명: "
        return label
    }()
    let itemNameInfoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "브랜드: "
        return label
    }()
    let brandInfoLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "사이즈: "
        return label
    }()
    let sizeInfoLabel: UILabel = {
        let label = UILabel()
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
        button.setTitleColor(UIColor.black, for: .normal)
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
                //make.width.equalToSuperview().multipliedBy(0.65)
                //make.height.equalToSuperview().multipliedBy(0.4)
                make.width.height.equalTo(150)
            }
            
            itemNameLabel.snp.makeConstraints { make in
                make.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
                make.top.equalTo(itemImageView.snp.bottom).offset(15)
            }
            
            itemNameInfoLabel.snp.makeConstraints { make in
                make.leading.equalTo(itemNameLabel.snp.trailing).offset(10)
                make.top.equalTo(itemNameLabel)
            }
            
            brandLabel.snp.makeConstraints { make in
                make.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
                make.top.equalTo(itemNameLabel.snp.bottom).offset(15)
            }
            
            brandInfoLabel.snp.makeConstraints { make in
                make.leading.equalTo(brandLabel.snp.trailing).offset(10)
                make.top.equalTo(brandLabel)
            }
            
            sizeLabel.snp.makeConstraints { make in
                make.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
                make.top.equalTo(brandLabel.snp.bottom).offset(15)
            }
            
            sizeInfoLabel.snp.makeConstraints { make in
                make.leading.equalTo(sizeLabel.snp.trailing).offset(10)
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
