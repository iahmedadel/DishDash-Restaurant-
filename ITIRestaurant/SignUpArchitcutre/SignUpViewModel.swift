//
//  SignUpViewModel.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 20/09/2024.
//

import Foundation
import Alamofire

class SignUpViewModel{
    var onSignUpSuccess: (() -> Void)?
    var onSignUpError: ((String) -> Void)?
    
    func postSignUp(name : String , email: String , password:String , phone : String) {
        
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "name": name ,
            "phone": phone
        ]
        AF.request(Apis.register, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { [self] response in
            switch response.result {
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let signUpResponse = try decoder.decode(SignUpResponse.self, from: data)
                    
                    if signUpResponse.status {
                        let profile = Profile(name: name, Phone: phone, Email: email, password: password)
                        
                        self.onSignUpSuccess?()
                        if let token = signUpResponse.token {
                            UserDefaults.standard.set(token, forKey: "authToken")
                        }
                
                    } else {
                        
                        self.onSignUpError?(signUpResponse.message)
                    }
                } catch {
                    self.onSignUpError?("Failed to decode the response.")
                }
            case .failure(let error):
                self.onSignUpError?(error.localizedDescription)
            }
        }
    }
    
}
