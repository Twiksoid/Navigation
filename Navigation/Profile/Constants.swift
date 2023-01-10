//
//  Constants.swift
//  Navigation
//
//  Created by Nikita Byzov on 13.07.2022.
//

import UIKit

enum LocalizitedKeys {
    static let keyTitleTextField = "keyTitleTextField" // "Hipster Cat"
    static let keyStatusTextField = "keyStatusTextField" //"Waitting for something ..."
    static let keyShowStatusButton = "keyShowStatusButton" // "Set status"
    static let keyViewTitle = "keyViewTitle" //"Profile"
    static let keyViewFavoriteTitle = "keyViewFavoriteTitle" // "Favorite"
    
    static let keyLogInButtonText = "keyLogInButtonText" // "Log In"
    static let keyEmail = "keyEmail" // "Email or phone"
    static let keyPassword = "keyPassword" // "Password"
    
    static let keyCollectionPhotoTitle = "keyCollectionPhotoTitle" // "Photo Gallery"
    
    static let keyAlertNotEnteredDataTitle = "keyAlertNotEnteredDataTitle" // "Не заполнено обязательное поле"
    static let keyAlertNotEnteredDataText = "keyAlertNotEnteredDataText" // "Проверьте информацию и попробуйте снова"
    static let keyAlertNotEnteredDataAction = "keyAlertNotEnteredDataAction" // "Ок"
    
    static let keyAlertNotCorrectLoginTitle = "keyAlertNotCorrectLoginTitle" // "Неверный логин или пароль"
    static let keyAalertNotCorrectLoginText = "keyAalertNotCorrectLoginText" // "Проверьте информацию и попробуйте снова"
    static let keyAlertNotCorrectLoginAction = "keyAlertNotCorrectLoginAction" // "Ок"
    
    static let keyGeneratePasswordField = "keyGeneratePasswordField" // "Подобрать пароль"
    static let keyRegistrationNewUser = "keyRegistrationNewUser" // "Регистрация"
    
    static let keyErrorRegistrationFireBase = "keyErrorRegistrationFireBase" // "Ошибка при регистрации"
    static let keyErrorLogInFireBase = "keyErrorLogInFireBase" // "Ошибка при входе"
    static let keyNotLoginUserTitleAlarm = "keyNotLoginUserTitleAlarm" // "Пользователь не авторизован"
    static let keyNotLoginUserTextAlarm = "keyNotLoginUserTextAlarm" // "Перейдите на вкладку Профиль и пройдите авторизацию"
    static let keyNotLoginUserAction = "keyNotLoginUserAction" // "Ок"
    static let keyFavoriteNoteExsist = "keyFavoriteNoteExsist" // "Заметка уже существует"
    static let keyFavoriteNoteExsistText = "keyFavoriteNoteExsistText" // "Добавление заметки еще раз невозможно"
    
    static let keyTitleAlertTextPicker = "keyTitleAlertTextPicker"
    static let keyAlertPlaceHolderPicler = "keyAlertPlaceHolderPicler"
    static let keyAlertTextPickerAdd = "keyAlertTextPickerAdd"
    static let keyAlertTextPickerCansel = "keyAlertTextPickerCansel"
    static let keyLikes = "keyLikes"
    static let keyViews = "keyViews"
    static let keyNameForMiniCollectionPhotos = "keyNameForMiniCollectionPhotos"
    static let keyTitleOfNavItemMapView = "keyTitleOfNavItemMapView"
    static let keyPullToRefreshText = "keyPullToRefreshText"
    static let keyPostNameOne = "keyPostNameOne"
    static let keyPostNameTwo = "keyPostNameTwo"
    static let keyPlaceholderTextForChec = "keyPlaceholderTextForChec"
    static let keyCheckEnteredWord = "keyCheckEnteredWord"
    static let keyTimeCheckWordExpired = "keyTimeCheckWordExpired"
    static let keyTryAgainFaster = "keyTryAgainFaster"
    static let keyTimeAlertOk = "keyTimeAlertOk"
    static let keyChangeTitileButtonText = "keyChangeTitileButtonText"
    static let keyYes = "keyYes"
    static let keyNo = "keyNo"
    static let keyNotEnteredField = "keyNotEnteredField"
    static let keyEnteredDataInFiled = "keyEnteredDataInFiled"
    static let keyThereIsNoData = "keyThereIsNoData"
    static let keyThereIsNoCorrectData = "keyThereIsNoCorrectData"
    static let keyCheckInteredDataAndTryAgain = "keyCheckInteredDataAndTryAgain"
    static let keyUnexpectedError = "keyUnexpectedError"
    static let keyUnxpectedErrorText = "keyUnxpectedErrorText"
    static let keyShowAlertInfoView = "keyShowAlertInfoView"
    static let keyLoadingText = "keyLoadingText"
    static let keyTextFiledValue = "keyTextFiledValue"
    static let keyPeriodPlanets = "keyPeriodPlanets"
    static let keyTitilePlanet = "keyTitilePlanet"
    static let keyTextMessagaPlanet = "keyTextMessagaPlanet"
    static let keyActionPlanetOne = "keyActionPlanetOne"
    static let keyActionPlanetTwo = "keyActionPlanetTwo"
    static let keyFeed = "keyFeed"
    static let keyProfile = "keyProfile"
    static let keyInfo = "keyInfo"
    static let keyFavorite = "keyFavorite"
    static let keyMap = "keyMap"
}

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
    static let viewFavoriteTitle = "Favorite"
    
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
    
    static let alertNotEnteredDataTitle = "Не заполнено обязательное поле"
    static let alertNotEnteredDataText = "Проверьте информацию и попробуйте снова"
    static let alertNotEnteredDataAction = "Ок"
    
    static let alertNotCorrectLoginTitle = "Неверный логин или пароль"
    static let alertNotCorrectLoginText = "Проверьте информацию и попробуйте снова"
    static let alertNotCorrectLoginAction = "Ок"
    
    static let generatePasswordField = "Подобрать пароль"
    static let registrationNewUser = "Регистрация"
    
    static let errorRegistrationFireBase = "Ошибка при регистрации"
    static let errorLogInFireBase = "Ошибка при входе"
    static let notLoginUserTitleAlarm = "Пользователь не авторизован"
    static let notLoginUserTextAlarm = "Перейдите на вкладку Профиль и пройдите авторизацию"
    static let notLoginUserAction = "Ок"
    static let favoriteNoteExsist = "Заметка уже существует"
    static let favoriteNoteExsistText = "Добавление заметки еще раз невозможно"
    static let nameForMiniCollectionPhotos = "Photos"
    static let titleOfNavItemMapView = "Маршрут"
    static let pullToRefreshText = "Для обновления потяните страницу вниз"
    
}

// обращаемся к цвету 4885CC , который задали в Assets
extension UIColor {
    static let specialBlue: UIColor = UIColor(named: "AccentColor")!
}

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
