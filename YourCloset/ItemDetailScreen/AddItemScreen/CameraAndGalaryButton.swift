//
//  CameraAndGalaryButton.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/25.
//

import Foundation
import UIKit

class CameraAndGalaryButton: UIButton {
    var pickImage = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemeted")
    }
}
