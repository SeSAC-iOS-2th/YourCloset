//
//  ProjectColor.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/16.
//

import Foundation
import UIKit

enum ProjectColor {
    case backgroundColor
    case tintColor1
    case tintColor2
    case tintColor3
}

extension UIColor {
    
    static func projectColor(_ color: ProjectColor) -> UIColor {
        switch color {
        case .backgroundColor:
            return UIColor(displayP3Red: 177/255, green: 178/255, blue: 255/255, alpha: 1)
        case .tintColor1:
            return UIColor(displayP3Red: 170/255, green: 196/255, blue: 255/255, alpha: 1)
        case .tintColor2:
            return UIColor(displayP3Red: 210/255, green: 218/255, blue: 255/255, alpha: 1)
        case .tintColor3:
            return UIColor(displayP3Red: 238/255, green: 241/255, blue: 255/255, alpha: 1)
            
        }
    }
}
