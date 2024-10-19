//
//  CategoryViewModel.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 24/09/2024.
//
import Foundation

class CategoryViewModel {
    private var categories: [String] = []
    
    var numberOfCategories: Int {
        return categories.count
    }
    
    func category(at index: Int) -> String {
        return categories[index]
    }
    
    func fetchCategories(completion: @escaping () -> Void) {
        MenuController.shared.fetchCategories { [weak self] categories in
            guard let self = self, let categories = categories else { return }
            self.categories = categories
            completion()
        }
    }
}
