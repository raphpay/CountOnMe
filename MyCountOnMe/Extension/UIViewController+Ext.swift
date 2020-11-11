//
//  UIViewController+Ext.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 08/11/2020.
//

import UIKit

extension UIViewController {
    func showSystemAlert(title : String = "❌ Oups, something went wrong ! ❌",
                         message: String = "Please try again later.",
                         type : UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
