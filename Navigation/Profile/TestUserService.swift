//
//  TestUserService.swift
//  Navigation
//
//  Created by Nikita Byzov on 15.09.2022.
//

import UIKit

class TestUserService: UserService {
    
    let user: User?
    
    init(user: User){
        self.user = user
    }
    
    // поскольку хотим ловить ошибки, то должны подписаться на протокол, где эти ошибки заводим
    // суть такая: вернем ошибку или пользователя
    func checkUser(for login: String,
                   and password: String,
                   completionHandler: @escaping (Result<User?, UserServiceError>) -> Void) {
        // эталонный пользователь, которому можно входить, хард-код
        // данный класс используем для отладки, считаем, что тестовым будет Иван
        let currentUser = User(login: "Ivan",
                               password: "123456",
                               fullName: "Ivan Petrov",
                               photo: UIImage(named: "Ivan.jpg")!,
                               status: "I'm free")
        
        if ( currentUser.login == login && currentUser.password == password ) {
            completionHandler(.success(currentUser))
        } else {
            completionHandler(.failure(.incorrectData))
        }
    }
}
