//
//  TextPicker.swift
//  Navigation
//
//  Created by Nikita Byzov on 23.12.2022.
//

import UIKit

class TextPicker {
    
    static let defaultPicker = TextPicker()
    
    func getText(in viewController: UIViewController, completion: ((_ text: String)->Void)? ) {
        let alertController = UIAlertController(title: "Укажите город", message: nil, preferredStyle: .alert)
        
        alertController.addTextField {
            textFiel in textFiel.placeholder = "Укажите город от которого нужно создать маршрут"
        }
        
        let actionOK = UIAlertAction(title: "Добавить", style: .default) { alert in
            if let text = alertController.textFields?[0].text, text != "" {
                completion?(text)
            }
        }
        
        let actionCansel = UIAlertAction(title: "Отменить", style: .cancel)
        
        alertController.addAction(actionOK)
        alertController.addAction(actionCansel)
        
        viewController.present(alertController, animated: true)
    }
}

