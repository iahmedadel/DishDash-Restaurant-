//
//  MenuViewModel 2.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 24/09/2024.
//


import Foundation

class MenuViewModel {
    private var categories = [String]()
    
    var didUpdateCategories: (() -> Void)?
    
    func fetchCategories() {
        MenuController.shared.fetchCategories { [weak self] (categories) in
            if let categories = categories {
                self?.categories = categories
                self?.didUpdateCategories?()
            }
        }
    }
    
    //  number of categories
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    // Get a category by index
    func category(at index: Int) -> String {
        return categories[index]
    }
}
