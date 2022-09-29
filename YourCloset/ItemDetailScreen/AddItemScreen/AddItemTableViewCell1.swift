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
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    let galaryButton: CameraAndGalaryButton = {
        let button = CameraAndGalaryButton()
        return button
    }()
    
    let galaryButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.circle.fill")
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    override var frame: CGRect {
        get {
            return super.frame
        } set(newFrame) {
            var frame = newFrame
            let newWidth = UIScreen.main.bounds.width * 0.65
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            super.frame = frame
        }
    }
    
    override func configure() {
        [itemImageView, galaryButton, galaryButtonImageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        itemImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            //make.width.height.equalTo(250)
            make.width.height.equalTo(UIScreen.main.bounds.width * 0.65)
        }
        
        galaryButton.snp.makeConstraints { make in
            make.centerX.equalTo(itemImageView.snp.trailing)
            make.centerY.equalTo(itemImageView.snp.bottom)
            make.height.width.equalTo(30)
        }
        
        galaryButtonImageView.snp.makeConstraints { make in
            make.edges.equalTo(galaryButton)
        }
    }
    
}
