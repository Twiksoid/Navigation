//
//  CheckerService.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.11.2022.
//

import Foundation
import FirebaseAuth
import UIKit

typealias handler = (Result<User, Error>) -> Void

protocol CheckerServiceProtocol {
    func signUp(for email: String, and password: String, completionFor completion: @escaping handler)
    
    func checkCredentials(for email: String, and password: String, completionFor completion: @escaping handler)
    
}

class CheckerService: CheckerServiceProtocol {
    func signUp(for email: String, and password: String, completionFor completion: @escaping handler) {
        
        Auth.auth().createUser(withEmail: email, password: password) { autDataResult, error in
            if error == nil {
                let user = User(login: email, password: password, fullName: "Nikita Ivanov", photo: UIImage(named: "Ivan.jpg")!, status: "Hello, FireBase!")
                print("User creaded by checkerService ", user)
                completion(.success(user))
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    
    func checkCredentials(for email: String, and password: String, completionFor completion: @escaping handler) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if error == nil {
                
                let user = User(login: "Kate", password: "12345", fullName: "Kate Baranova", photo: UIImage(named: "Baranova.jpg")!, status: "I'm not sure about your physical abilities")
                print("User checked in checkerService ", user)
                completion(.success(user))
            } else {
                completion(.failure(error!))
            }
        }
    }
}

