//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Nikita Byzov on 15.09.2022.
//

import UIKit

class CurrentUserService: UserService {
    
    let user: User?
    
    init(user: User){
        self.user = user
    }
    
    // поскольку хотим ловить ошибки, то должны подписаться на протокол, где эти ошибки заводим
    // суть такая: вернем ошибку или пользователя
    func checkUser(for login: String, and password: String, completionHandler: @escaping (Result<User, UserServiceError>) -> Void) {
        // эталонный пользователь, которому можно входить, хард-код
        // для релиза используем своего пользователя, считаем, что это Катя
        let currentUser = User(login: "Kate", password: "12345", fullName: "Kate Baranova", photo: UIImage(named: "Baranova.jpg")!, status: "I'm not sure about your physical abilities")
        
        if ( currentUser.login == login && currentUser.password == password ) {
            completionHandler(.success(currentUser))
        } else {
            return completionHandler(.failure(.incorrectData))
        }
    }
}
