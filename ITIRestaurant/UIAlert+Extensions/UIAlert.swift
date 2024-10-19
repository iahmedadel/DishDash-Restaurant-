//
//  UIAlert.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import Foundation
import UIKit
extension UIViewController{
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
