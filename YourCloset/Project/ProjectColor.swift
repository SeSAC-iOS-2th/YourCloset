//
//  ProjectColor.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/28.
//

import Foundation
import UIKit

enum ProjectColor {
    case backgroundColor
    case closetColor
    case closetEdgeColor
    case itemColor
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func projectColor(_ color: ProjectColor) -> UIColor {
        switch color {
        case .backgroundColor:
            return UIColor(r: 213, g: 213, b: 213)
        case .closetColor:
            return UIColor(r: 244, g: 184, b: 120)
        case .closetEdgeColor:
            return UIColor(r: 161, g: 115, b: 77)
        case .itemColor:
            return UIColor(r: 95, g: 94, b: 94)
        }
    }
}
