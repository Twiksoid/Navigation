//
//  Checker.swift
//  Navigation
//
//  Created by Nikita Byzov on 19.09.2022.
//

import UIKit

class Checker {
    static let shared = Checker()

    // хард-код
#if DEBUG
    private let login = "Ivan"
    private let password = "123456"
#else
    private let login = "Kate"
    private let password = "12345"
#endif

    private init() {}
    
    func check(for login: String, and password: String) -> Bool {
        if self.login == login && self.password == password {
            return true
        } else {
            return false
        }
    }
}

protocol LoginViewControllerDelegate {
    func check(for login: String, and password: String) -> Bool
}

extension LoginViewControllerDelegate {
    func check(for login: String, and password: String) -> Bool {
        return Checker.shared.check(for: login, and: password)
    }
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(for login: String, and password: String) -> Bool {
        return Checker.shared.check(for: login, and: password)

    }
}
