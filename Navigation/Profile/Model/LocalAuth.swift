//
//  LocalAuth.swift
//  Navigation
//
//  Created by Nikita Byzov on 20.01.2023.
//

import UIKit
import LocalAuthentication

class LocalAuthorizationService: UIViewController {
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        
        let contex = LAContext()
        var errorInBiometria: NSError?
        var isBiometriaAllowed: Bool = false
        
        if contex.canEvaluatePolicy(.deviceOwnerAuthentication, error: &errorInBiometria) {
            isBiometriaAllowed = true
        }
        if isBiometriaAllowed == true {
            contex.evaluatePolicy(.deviceOwnerAuthentication,
                                  localizedReason: NSLocalizedString(LocalizitedKeys.textForPasswordBioAuth, comment: "")) { [weak self] succsess, error in
                if let error = error { print(error.localizedDescription) }
                
                DispatchQueue.main.async {
                    
                    if succsess == true {
                        self?.showAlertLogin()
                    } else {
                        self?.showAlertNotLogin(text: error?.localizedDescription ?? "No error text")
                    }
                }
            }
        }
    }
    
    private func showAlertLogin(){
        let alert = UIAlertController(title: "Успех", message: "Авторизация пройдена", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    private func showAlertNotLogin(text error: String){
        let alert = UIAlertController(title: "Неудача", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
