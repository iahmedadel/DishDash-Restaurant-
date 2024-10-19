//
//  MenuTableViewController.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var category: String?
    var menuItems = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.capitalized
        MenuController.shared.fetchMenuItems(categoryName: category ?? "") { (menuItems) in
            if let menuItems = menuItems{
                self.updateUI(with: menuItems)
            }
        }
    }
    
    func updateUI(with menuItems: [MenuItem]){
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellIdentifier", for: indexPath)
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(menuItem.price) + "EGP"
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
              
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath { return }
                cell.imageView?.image = image
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue"{
            let menuItemDetailViewController = segue.destination as? MenuItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            
            menuItemDetailViewController?.menuItem = menuItems[index]
        }
    }
    

}
