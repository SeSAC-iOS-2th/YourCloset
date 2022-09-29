//
//  NothingToBuyView.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/28.
//

import Foundation
import UIKit
import SnapKit

class NothingToBuyView: BaseView {
    
    let noticeLabel1: UILabel = {
        let label = UILabel()
        label.text = "구매 예정인 옷들을 등록해보세요!"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ToCloset")
        return imageView
    }()
    
    let noticeLabel2: UILabel = {
        let label = UILabel()
        label.text = "*구매한 옷은 옷장으로\n 이동시킬 수 있습니다."
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    let justView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    override func configure() {
        [noticeLabel1, imageView, noticeLabel2, justView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        noticeLabel1.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.height.equalTo(50)
            make.bottom.equalTo(imageView.snp.top)
        }
        noticeLabel2.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.centerX)
            make.height.equalTo(50)
            make.top.equalTo(imageView.snp.bottom)
        }
        justView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView).offset(40)
            make.bottom.equalTo(noticeLabel2)
            make.width.equalTo(noticeLabel1)
        }
    }
}
