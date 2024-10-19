import Foundation

class MenuTableViewModel {
    var category: String?
    var menuItems = [MenuItem]()
    
    func fetchMenuItems(completion: @escaping ([MenuItem]) -> Void) {
        guard let category = category else { return }
        MenuController.shared.fetchMenuItems(categoryName: category) { [weak self] (menuItems) in
            if let menuItems = menuItems {
                self?.menuItems = menuItems
                completion(menuItems)
            } else {
                completion([])
            }
        }
    }
}
