//
//  UIViewController+Extensions.swift
//  chat_app
//
//  Created by Admin on 11/15/21.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func hideKeyBoardWhenTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
