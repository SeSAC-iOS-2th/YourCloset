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
    
    let justLabel: UILabel = {
        let label = UILabel()
        label.text = "구매 예정인 옷들을 등록해보세요!"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func configure() {
        self.addSubview(justLabel)
    }
    
    override func setConstraints() {
        justLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(150)
        }
    }
}
