//
//  Constants.swift
//  Navigation
//
//  Created by Nikita Byzov on 13.07.2022.
//

import UIKit

enum Constants {
    static let statusTextFieldTap = 1000
    static let showStatusButtonTap = 1001
    static let titleTextFieldTap = 1002
    static let avatarImageViewTap = 1003
    static let enteringStatusTextFieldTap = 1004
    static let logInButtonTap = 1005
    
    static let mainPhoto = "cat.png"
    static let titleTextField = "Hipster Cat"
    static let statusTextField = "Waitting for something ..."
    static let enteringStatusTextField = ""
    static let showStatusButton = "Set status"
    static let viewTitle = "Profile"
    
    static let logoName = "logo.png"
    static let pixelBlue = "blue_pixel.png"
    static let logInButtonText = "Log In"
    static let email = "Email or phone"
    static let password = "Password"
    
    static let collectionPhotoTitle = "Photo Gallery"
    static let numberOfItemInMiniCollection = 4
    static let numberOfSections = 1
    static let numberOfItemsInSection = 20
    static let numberOfItemsInLine: CGFloat = 3
}

// обращаемся к цвету 4885CC , который задали в Assets
extension UIColor {
    static let specialBlue: UIColor = UIColor(named: "specialBlue")!
}
