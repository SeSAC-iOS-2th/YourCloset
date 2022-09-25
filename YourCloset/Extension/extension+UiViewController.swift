//
//  extension+UiViewController.swift
//  YourCloset
//
//  Created by 이중원 on 2022/09/25.
//

import Foundation
import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedBackground() {
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapEvent.cancelsTouchesInView = false
        view.addGestureRecognizer(tapEvent)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
