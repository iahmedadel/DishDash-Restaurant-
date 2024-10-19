//
//  LoginViewModel.swift
//  ITIRestaurant
//
//  Created by MacBook Pro on 20/09/2024.

import Foundation
import Alamofire

class LoginViewModel {
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?  

    func postLogin(email: String, password: String) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request(Apis.login, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { [self] response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(SignUpResponse.self, from: data)

                    if loginResponse.status {
                        self.onLoginSuccess?()
                    } else {
                        self.onLoginFailure?(loginResponse.message)
                    }
                } catch {
                    self.onLoginFailure?("Failed to decode response.")
                }

            case .failure(let error):
                self.onLoginFailure?(error.localizedDescription)
            }
        }
    }
}
