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
        // This function create a custom alert to display in case of error. The title and the message takes default parameters.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
