
import Foundation
import UIKit

class MenuItemDetailViewModel {
     var menuItem: MenuItem?
    
    var itemName: String {
        return menuItem?.name ?? ""
    }
    
    var itemPrice: String {
        return "\(menuItem?.price ?? 0) EGP"
    }
    
    var itemDescription: String {
        return menuItem?.description ?? ""
    }
    
    func setMenuItem(_ item: MenuItem) {
        self.menuItem = item
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = menuItem?.imageURL else {
            completion(nil)
            return
        }
        
        MenuController.shared.fetchImage(url: url, completion: completion)
    }
}
