//
//  profileViewController.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 20/09/2024.
//

import UIKit
import Alamofire

class profileViewController: UIViewController {
    var profile: Profile?


    @IBOutlet weak var profileTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
       fetchUserProfile()

        profileTableView.reloadData()

    }
    func fetchUserProfile() {
        

        profile = Profile(name: "Ahmed Adel" , Phone: "0112019926", Email: "ahmed.1.2.3.4@gmail.com", password: "123456")
        
        // Reload the table view after setting the profile
        profileTableView.reloadData()
    }


}
    
    extension profileViewController: UITableViewDelegate , UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = profileTableView.dequeueReusableCell(withIdentifier: "profileTableViewCell") as! profileTableViewCell

            guard let profile = profile else {
                       print("Profile is nil, cannot reload table view")
                       return cell
                   }

                   switch indexPath.row {
                   case 0:
                       cell.textLabel?.text = "Name"
                       cell.textLabel?.textColor = .white
                       cell.textLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 25)
                       cell.detailTextLabel?.text = profile.name
                       cell.detailTextLabel?.textColor = .white

                   case 1:
                       cell.textLabel?.text = "Email"
                       cell.textLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 25)
                       cell.textLabel?.textColor = .white
                       cell.detailTextLabel?.textColor = .white


                       cell.detailTextLabel?.text = profile.Email
                   case 2:
                       cell.textLabel?.text = "Phone"
                       cell.textLabel?.textColor = .white
                       cell.textLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 25)

                       cell.detailTextLabel?.text = profile.Phone
                       cell.detailTextLabel?.textColor = .white

                   case 3:
                       cell.textLabel?.text = "Password"
                       cell.textLabel?.textColor = .white
                       cell.textLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 25)

                       cell.detailTextLabel?.text = profile.password
                       cell.detailTextLabel?.textColor = .white

                   default:
                       break
                   }
            return cell
        }
        
        
    }

