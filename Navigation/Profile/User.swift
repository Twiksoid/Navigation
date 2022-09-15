//
//  User.swift
//  Navigation
//
//  Created by Nikita Byzov on 15.09.2022.
//

import UIKit

class User {
    let login: String
    let password: String
    let fullName: String
    let photo: UIImage
    let status: String
    
    init(login: String, password: String, fullName: String, photo: UIImage, status: String){
        self.login = login
        self.password = password
        self.fullName = fullName
        self.photo = photo
        self.status = status
    }
}

protocol UserService {
    func checkUser(for login: String, and password: String) -> User?
}
