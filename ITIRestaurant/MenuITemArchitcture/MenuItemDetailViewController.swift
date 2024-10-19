//
//  MenuItemDetailViewController.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import UIKit

protocol AddToOrderDelegate {
    func added(menuItem: MenuItem)
}

class MenuItemDetailViewController: UIViewController {
    var menuItem: MenuItem?
    
    var delegate: AddToOrderDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()
        addToOrderButton.layer.cornerRadius = 15
        self.navigationController?.navigationBar.titleTextAttributes = [
               NSAttributedString.Key.foregroundColor: UIColor.white ]
    }

    func updateUI(){
        guard let menuItem = menuItem else {
                   print("Menu item is missing")
                   return
               }
        titleLabel.text = menuItem.name
        priceLabel.text = String(menuItem.price) + "EGP"
        descriptionLabel.text = menuItem.description
        
        addToOrderButton.layer.cornerRadius = 5.0
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    func setupDelegate(){
        if let navController = tabBarController?.viewControllers?.last as? UINavigationController{
            if let orderTableViewController = navController.viewControllers.first as? OrderTableViewController{
                delegate = orderTableViewController
            }
        }
        
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        if let menuItem = menuItem {
                    delegate?.added(menuItem: menuItem)
                } else {
                    print("Menu item is missing")
                }    }

}
