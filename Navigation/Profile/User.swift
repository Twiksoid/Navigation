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

// создаем перечисление ошибок
// считаем, что может быть ошибка данных
// или какая-то случайная
enum UserServiceError: Error {
    case incorrectData
    case notDeterminatedError
}

// подписываемся на ошибки
protocol UserService {
    func checkUser(for login: String,
                   and password: String,
                   completionHandler: @escaping (Result<User?, UserServiceError>) -> Void)
}
