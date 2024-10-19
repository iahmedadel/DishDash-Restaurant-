//
//  OrderTableViewController.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import UIKit
import UserNotifications

class OrderTableViewController: UITableViewController, AddToOrderDelegate {
   
    var menuItems = [MenuItem]()
    var orderMinutes: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

    }


    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)
        
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "", menuItem.price)
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath { return }
                cell.imageView?.image = image
            }
        }

        return cell
    }
    
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        
        let count = menuItems.count
        let indexPath = IndexPath(row: count-1, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }
    
    func updateBadgeNumber(){
        let badgeValue = menuItems.count > 0 ? "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            menuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func uploadOrder(){
        let menuIDs = menuItems.map{ $0.id}
        MenuController.shared.submitOrder(menuIds: menuIDs) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func submitTapped(_ sender: UIBarButtonItem) {
        let orderTotal = menuItems.reduce(0.0) { (result, menuItem) -> Double in
            return result + menuItem.price
        }
        
        let formattedOrder = String( orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        
        let submit = UIAlertAction(title: "Submit", style: .default) { (action) in self.uploadOrder() }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(submit)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
            menuItems.removeAll()
            tableView.reloadData()
            updateBadgeNumber()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination as? OrderConfirmationViewController
            orderConfirmationViewController?.minutes = orderMinutes
            
            notification(time: orderMinutes)
        }
    }
    
    func notification(time: Int){
        let timeInSec = (time - 5)*60
        
        let notification = UNMutableNotificationContent()
        notification.title = "Hello Dear"
        notification.body = "Your Order will be here soon"
        notification.sound = UNNotificationSound.default

        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInSec), repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    

}
