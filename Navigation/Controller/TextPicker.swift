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
        let alertController = UIAlertController(title: NSLocalizedString(LocalizedKeys.keyTitleAlertTextPicker, comment: ""),
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addTextField {
            textFiel in textFiel.placeholder = NSLocalizedString(LocalizedKeys.keyAlertPlaceHolderPicler, comment: "")
        }
        
        let actionOK = UIAlertAction(title: NSLocalizedString(LocalizedKeys.keyAlertTextPickerAdd, comment: ""),
                                     style: .default) { alert in
            if let text = alertController.textFields?[0].text, text != "" {
                completion?(text)
            }
        }
        
        let actionCansel = UIAlertAction(title: NSLocalizedString(LocalizedKeys.keyAlertTextPickerCansel, comment: ""),
                                         style: .cancel)
        
        alertController.addAction(actionOK)
        alertController.addAction(actionCansel)
        
        viewController.present(alertController, animated: true)
    }
}

