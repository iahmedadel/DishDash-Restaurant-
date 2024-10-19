////
////  OrderViewModel.swift
////  ITIRestaurant
////
////  Created by MacBook Pro on 24/09/2024.
////
//
import Foundation

class OrderViewModel {
    var menuItems: [MenuItem] = []
    var orderMinutes: Int = 0
    
    func addToOrder(menuItem: MenuItem) {
        menuItems.append(menuItem)
    }
    
    func submitOrder(completion: @escaping (Int?) -> Void) {
        let menuIDs = menuItems.map { $0.id }
        MenuController.shared.submitOrder(menuIds: menuIDs) { [weak self] minutes in
            if let minutes = minutes {
                self?.orderMinutes = minutes
                completion(minutes)
            }
        }
    }
    
    func orderTotal() -> Double {
        return menuItems.reduce(0.0) { $0 + $1.price }
    }
}
