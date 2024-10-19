//
//  ViewController.swift
//  Restaurant
//


import UIKit
//import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageVieaAnimation: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateImage()
//        navigateToSignUp()

    }
    func rotateImage() {
            let rotation = CABasicAnimation(keyPath: "transform.rotation")
            rotation.fromValue = 0
            rotation.toValue = Double.pi * 4
            rotation.duration = 3  // Duration of the animation
            rotation.repeatCount = 1  // Perform the animation once
        imageVieaAnimation.layer.add(rotation, forKey: "rotateAnimation")
        DispatchQueue.main.asyncAfter(deadline: .now() + rotation.duration) {
                    self.navigateToSignUp()
                }
        
        }
    func navigateToSignUp(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
         let vc = sb.instantiateViewController(withIdentifier: "firstOnBoarding")
                  vc.modalPresentationStyle = .fullScreen
                  self.present(vc, animated: true, completion: nil)   //to SignUpViewController
             
//print("Error: Could not instantiate SignUpViewController")
              
          }
       
}
