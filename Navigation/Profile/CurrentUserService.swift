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
    
    func checkUser(for login: String, and password: String) -> User? {
        // эталонный пользователь, которому можно входить, хард-код
        // для релиза используем своего пользователя, считаем, что это Катя
        let currentUser = User(login: "Kate", password: "12345", fullName: "Kate Baranova", photo: UIImage(named: "Baranova.jpg")!, status: "I'm not sure about your physical abilities")
        
        if ( currentUser.login == login && currentUser.password == password ) {
            return currentUser
        } else { return nil }
    }
}
