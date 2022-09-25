//
//  extension+String.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/25.
//

import Foundation
import UIKit

extension String {
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
}
