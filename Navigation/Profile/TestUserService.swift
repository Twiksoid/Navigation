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
    
    func checkUser(for login: String, and password: String) -> User? {
        // эталонный пользователь, которому можно входить, хард-код
        // данный класс используем для отладки, считаем, что тестовым будет Иван
        let currentUser = User(login: "Ivan", password: "123456", fullName: "Ivan Petrov", photo: UIImage(named: "Ivan.jpg")!, status: "I'm free")
        
        if ( currentUser.login == login && currentUser.password == password ) {
            return currentUser
        } else { return nil }
    }
}
