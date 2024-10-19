//
//  loginVC.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 16/09/2024.
//

import UIKit
import Alamofire
import LocalAuthentication
var context = LAContext()
var viewModel = LoginViewModel()
class loginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelClosures()
        setupAuthenticationContext()

          }
    private func setupAuthenticationContext() {
         context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        
        
        
        
    }
    func setupViewModelClosures(){
        
        
        viewModel.onLoginSuccess = { [weak self] in
            print("Login successful")
            self?.navigateToMainTabBar()
        }

                viewModel.onLoginFailure = { [weak self] error in
                    print("Login failed with error: \(error)")
                    self?.showAlert(title: "Error", message: error) 
                }
        
        
        
        
        
        
        
        
        
    }
    private func authenticateUser(completion: @escaping (Bool) -> Void) {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Login into app"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            print(error?.localizedDescription ?? "Nothing Found")
            completion(false)
        }
    }
 
    
    
    
    func navigateToMainTabBar() {

        if let tabBarController = storyboard?.instantiateViewController(withIdentifier: "mainTabbar") as? mainTabbar {
            if #available(iOS 13.0, *) {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                }
            } else {
            }
            }
        
    }

    
    

    func authUser(){
        authenticateUser { [weak self] success in
                guard let self = self else { return }
                if success {
                    self.navigateToMainTabBar()
                } else {
                    self.showAuthenticationFailedAlert()
                }
            }
    }
    
    private func showAuthenticationFailedAlert() {
        let alert = UIAlertController(title: "Authentication Failed", message: "Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTxt.text, !email.isEmpty,
                     let password = passwordTxt.text, !password.isEmpty else {
                   showAlert(title: "Error", message: "Please enter all data")
                   return
               }
               
               // Call the login function
               viewModel.postLogin(email: email, password: password)
        
    }
}

