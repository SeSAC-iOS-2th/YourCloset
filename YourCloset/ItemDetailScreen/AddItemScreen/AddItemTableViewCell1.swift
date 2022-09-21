//
//  AddItemTableViewCell1.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/21.
//

import Foundation
import UIKit
import SnapKit

class AddItemTableViewCell1: BaseTableViewCell {
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    let galaryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.contentMode = .scaleToFill
        button.tintColor = .gray
        return button
    }()
    
    override func configure() {
        [itemImageView, galaryButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        
        galaryButton.snp.makeConstraints { make in
            make.centerX.equalTo(itemImageView.snp.trailing)
            make.centerY.equalTo(itemImageView.snp.bottom)
            make.height.width.equalTo(30)
        }
    }
    
}
