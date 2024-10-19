//
//  CategoryTableViewController.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//
import UIKit

class CategoryTableViewController: UITableViewController {
    
    private var viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchCategories()
        initNotificationSetupCheck()
    }
    
    private func setupBindings() {
        viewModel.didUpdateCategories = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCategories()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        cell.textLabel?.text = viewModel.category(at: indexPath.row).capitalized
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as? MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController?.category = viewModel.category(at: index)
        }
    }
    
    func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (success, error) in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    }
}
