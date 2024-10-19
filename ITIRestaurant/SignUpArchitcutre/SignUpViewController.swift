//
//  SignUpViewController.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    var signupViewModel = SignUpViewModel()
    var profile: Profile?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
      
    }

    func bindViewModel(){
           
        signupViewModel.onSignUpSuccess = { [weak self ] in
            self?.navigateToLogin()
        
        }
        signupViewModel.onSignUpError = { [weak self] errorMessage in
            self?.showAlert(title: "Error", message: errorMessage)

            
            
        }
    }
    
    func navigateToLogin (){
        print("Navigating to login screen")

           let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "loginVC")
               vc.modalPresentationStyle = .fullScreen
               
                   print("Presenting login view controller") // Debugging log
                   self.present(vc, animated: true, completion: nil)
               
      
              }
   

    @IBAction func signUpTapped(_ sender: Any) {
        
//        postSignUp()
        guard let name = nameTxt.text , !name.isEmpty ,
              let email = emailTxt.text , !email.isEmpty ,
              let phone = phoneTxt.text , !phone.isEmpty ,
              let password = passwordTxt.text , !password.isEmpty else {
            showAlert(title: "Error", message: "Please enter all valid data")
            return }
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let profile = Profile(name: name, Phone: phone, Email: email, password: password)
        if let profileVC = sb.instantiateViewController(withIdentifier: "ProfileViewController") as? profileViewController {
            profileVC.profile = profile
        }
        signupViewModel.postSignUp(name: name, email: email, password: password, phone: phone)
        
    }
    
}
