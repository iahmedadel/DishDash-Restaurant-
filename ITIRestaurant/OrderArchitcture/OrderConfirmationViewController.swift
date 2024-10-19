//
//  OrderConfirmationViewController.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! your wait time is approximately \(minutes ?? 0 ) minutes."
    }



}
