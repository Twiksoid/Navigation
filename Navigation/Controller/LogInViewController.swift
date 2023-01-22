//
//  LogInViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 23.07.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import RealmSwift
import LocalAuthentication

class LogInViewController: UIViewController {
    
    // MARK: All variables
    
    var authModel = AuthorizationModel()
    
    var loginDelegate: LoginViewControllerDelegate?
    
    let concurrentQuee = DispatchQueue(label: "queueForPassword",
                                       qos: .userInteractive,
                                       attributes: [.concurrent])
    
    let contex = LAContext()
    var errorInBiometria: NSError?
    var imageBiometriaName = "faceid"
    var isBiometriaAllowed: Bool = false
    
    // MARK: All elements
    
    private lazy var logoImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: Constants.logoName)
        image.clipsToBounds = true
        image.layer.borderColor = (UIColor.createColor(lightMode: .white, darkMode: .black)).cgColor
        image.layer.borderWidth = 0.0
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackLogoImage: UIStackView = {
        let lStack = UIStackView()
        lStack.layer.borderColor = (UIColor.createColor(lightMode: .white, darkMode: .black)).cgColor
        lStack.layer.borderWidth = 0.0
        lStack.layer.cornerRadius = 10
        lStack.clipsToBounds = true
        lStack.alignment = .fill
        lStack.spacing = 0
        lStack.distribution = .fillEqually
        lStack.axis = .vertical
        lStack.translatesAutoresizingMaskIntoConstraints = false
        lStack.addArrangedSubview(logoImage)
        return lStack
    }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.layer.borderColor = UIColor.lightGray.cgColor
        email.layer.borderWidth = 0.5
        email.textAlignment = .left
        email.font = .systemFont(ofSize: 16)
        email.backgroundColor = .systemGray6
        email.placeholder = NSLocalizedString(LocalizitedKeys.keyEmail, comment: "")
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        email.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        return email
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        password.textAlignment = .left
        password.font = .systemFont(ofSize: 16)
        password.isSecureTextEntry = true
        password.backgroundColor = .systemGray6
        password.placeholder = NSLocalizedString(LocalizitedKeys.keyPassword, comment: "")
        password.autocapitalizationType = .none
        password.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        return password
    }()
    
    private lazy var stackTextFields: UIStackView = {
        let tStack = UIStackView()
        tStack.layer.borderColor = UIColor.lightGray.cgColor
        tStack.layer.borderWidth = 0.5
        tStack.layer.cornerRadius = 10
        tStack.clipsToBounds = true
        tStack.alignment = .fill
        tStack.spacing = 0
        tStack.distribution = .fillEqually
        tStack.axis = .vertical
        tStack.translatesAutoresizingMaskIntoConstraints = false
        tStack.addArrangedSubview(emailTextField)
        tStack.addArrangedSubview(passwordTextField)
        return tStack
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: LocalizitedKeys.keyLogInButtonText,
                                  titleColor: .white,
                                  backgroundButtonColor: UIColor(named: "AccentColor")!,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 10,
                                  autoLayout: false)
        button.tag = Constants.logInButtonTap
        button.addTargetForButton = { self.goToProfileViewController(sender: button) }
        return button
    }()
    
    // Чтобы упростить себе жизнь кнопка брутфорса с прошлых ДЗ переделана на Регистрация
    // весь код брутфорса удален
    private lazy var registerNewUserButton: CustomButton = {
        let buttom = CustomButton(title: LocalizitedKeys.keyRegistrationNewUser,
                                  titleColor: .white,
                                  backgroundButtonColor: .specialBlue,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 10,
                                  autoLayout: false)
        buttom.addTargetForButton = { self.registerNewUser() }
        return buttom
    }()
    
    private lazy var buttonForBiometricalAuth: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString(LocalizitedKeys.keyButtonBiometricalAuth, comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .specialBlue
        button.setImage(UIImage(systemName: imageBiometriaName), for: .normal)
        button.imageView?.tintColor = .systemBackground
        button.isHidden = isBiometriaAllowed
        button.addTarget(self, action: #selector(loginByBiometrica), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Нужен для красоты, чтобы было понятно, что в сеть запрос ушел
    // в целом, можно было и не делать
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        indicator.color = .black
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var stackButton: UIStackView = {
        let bStack = UIStackView()
        bStack.distribution = .fillEqually
        bStack.sizeToFit()
        bStack.axis = .vertical
        bStack.spacing = 5
        bStack.translatesAutoresizingMaskIntoConstraints = false
        bStack.addArrangedSubview(logInButton)
        bStack.addArrangedSubview(registerNewUserButton)
        return bStack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    
    // MARK: All funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
        skipLoginVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // рповеряю в принципе существование биометрии и необходимость отображения кнопки входа по ней
        if contex.canEvaluatePolicy(.deviceOwnerAuthentication, error: &errorInBiometria) {
            isBiometriaAllowed = true
            if contex.biometryType == .touchID {
                imageBiometriaName = "touchid"
            } else if contex.biometryType == .faceID {
                imageBiometriaName = "faceid"
            } else {
                imageBiometriaName = "bandage"
            }
        }
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didHideKeyBoard(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // чтобы клавиатура сразу была в поле email
        //  emailTextField.becomeFirstResponder()
    }
    
    private func setupView(){
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        navigationController?.navigationBar.isHidden = true
        // на вью добавить скролл
        view.addSubview(scrollView)
        // в скролл добавить стеки с полями и кнопкой
        scrollView.addSubview(stackLogoImage)
        scrollView.addSubview(stackTextFields)
        scrollView.addSubview(stackButton)
        scrollView.addSubview(buttonForBiometricalAuth)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackLogoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            stackLogoImage.heightAnchor.constraint(equalToConstant: 100),
            stackLogoImage.widthAnchor.constraint(equalToConstant: 100),
            stackLogoImage.bottomAnchor.constraint(equalTo: stackTextFields.topAnchor, constant: -120),
            stackLogoImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackTextFields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackTextFields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackTextFields.heightAnchor.constraint(equalToConstant: 100),
            
            stackButton.topAnchor.constraint(equalTo: stackTextFields.bottomAnchor, constant: 16),
            stackButton.leadingAnchor.constraint(equalTo: stackTextFields.leadingAnchor),
            stackButton.trailingAnchor.constraint(equalTo: stackTextFields.trailingAnchor),
            stackButton.heightAnchor.constraint(equalToConstant: 70),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: stackTextFields.centerYAnchor, constant: 26),
            
            buttonForBiometricalAuth.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonForBiometricalAuth.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonForBiometricalAuth.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonForBiometricalAuth.heightAnchor.constraint(equalToConstant: 50),
            buttonForBiometricalAuth.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    private func saveLoginData(login: String, password: String){
        // тут будем сохранять данные по логину, если он был успешен (это как регистрация, так и обычный вход)
        let realm = try! Realm()
        try! realm.write({
            let user = AuthorizationModel()
            user.login = login
            user.password = password
            user.isLogin = true
            realm.add(user)
        })
    }
    
    @objc private func loginByBiometrica(){
        
        if isBiometriaAllowed == true {
            contex.evaluatePolicy(.deviceOwnerAuthentication,
                                  localizedReason: NSLocalizedString(LocalizitedKeys.textForPasswordBioAuth, comment: "")) { [weak self] succsess, error in
                if let error = error { print(error.localizedDescription) }
                
                DispatchQueue.main.async {
                    
                    if succsess == true {
                        self?.skipLoginVC()
                    } else {
                        self?.showAlertNotLoginByBiometrical(text: error?.localizedDescription ?? "No error text")
                    }
                }
            }
        }
    }
    
    private func isUserExistAndAuth() -> Bool {
        // тут будем отслеживать наличие авторизации
        
        let realm = try! Realm()
        let authUsers = realm.objects(AuthorizationModel.self)
        
        // тут вернем все пользователей, у которых есть авторизация. По идее там всегда будет один
        let isUserAuth = authUsers.contains(where: { $0.isLogin == true } )
        if isUserAuth { return true } else { return false }
    }
    
    private func skipLoginVC() {
        // на будущее
        // когда будут разные юзеры, то нужно будет исправить метод,
        // чтобы получать из метода isUserExistAndAuth найденого пользователя (весь, а не просто авторизованный тк будем
        // использовать реального юзера, а не просто создавать случайного)
        if isUserExistAndAuth() == true {
            // если у нас уже есть авторизация, то сразу идем к следующему контроллеру
            // поскольку у нас нет юзеров в базе, то берем просто вручную созданного
            // в данном случае будет Катя тк она сейчас в сервисе checkCredentials
            // на будущее - пароль хранить через хеш-функцию в базе, при авторизации сравнивать введенный (преобразование в хеш)
            let user = User(login: "Kate",
                            password: "12345",
                            fullName: "Kate Baranova",
                            photo: UIImage(named: "Baranova.jpg")!,
                            status: NSLocalizedString(LocalizitedKeys.keyStatusForRandomUser, comment: ""))
            let goToProfileViewController = ProfileViewController(user: user)
            goToProfileViewController.modalPresentationStyle = .currentContext
            self.navigationController?.pushViewController(goToProfileViewController, animated: true)
        } else { showAlertNotAuthUser() }
    }
    
    // поскольку код переиспользуется, то вынесено в отдельный метод
    private func isFieldsIsNill(email eText: String, login lText: String) -> Bool {
        if (eText != "") && (lText != "") {
            return true
        } else {
            return false
        }
    }
    
    @objc private func goToProfileViewController(sender: UIButton) {
        if sender.tag == Constants.logInButtonTap {
            setupActivityIndicator()
            hideKeyboard()
            if isFieldsIsNill(email: emailTextField.text ?? "", login: passwordTextField.text ?? "") == true {
                
                let checkerService = CheckerService()
                checkerService.checkCredentials(for: emailTextField.text!, and: passwordTextField.text!) { result in
                    switch result {
                    case .success(let user):
                        self.deSetupActivityIndicator()
                        // Сохраним в REALM данные
                        self.saveLoginData(login: self.emailTextField.text!, password: self.passwordTextField.text!)
                        let goToProfileViewController = ProfileViewController(user: user)
                        goToProfileViewController.modalPresentationStyle = .currentContext
                        self.navigationController?.pushViewController(goToProfileViewController, animated: true)
                        
                    case .failure(let error):
                        self.deSetupActivityIndicator()
                        self.showAlertNotCorrectDataFireBase(error: error.localizedDescription)
                        print(String(describing: error))
                    }
                }
            } else {
                deSetupActivityIndicator()
                // логин или пароль неверный
                showAlertNotCorrectData()
            }} else {
                deSetupActivityIndicator()
                // логин или пароль не ввели
                showAlertNotEnteredData()
            }
    }
    
    @objc private func registerNewUser(){
        setupActivityIndicator()
        hideKeyboard()
        // если поля заполнены, то можно идти дальше
        if isFieldsIsNill(email: emailTextField.text ?? "", login: passwordTextField.text ?? "") == true {
            
            let checkerService = CheckerService()
            checkerService.signUp(for: emailTextField.text!, and: passwordTextField.text!) { result in
                switch result {
                case .success(let user):
                    self.deSetupActivityIndicator()
                    // Сохраним в REALM данные
                    self.saveLoginData(login: self.emailTextField.text!, password: self.passwordTextField.text!)
                    let goToProfileViewController = ProfileViewController(user: user)
                    goToProfileViewController.modalPresentationStyle = .currentContext
                    self.navigationController?.pushViewController(goToProfileViewController, animated: true)
                case .failure(let error):
                    self.deSetupActivityIndicator()
                    self.showAlertNotRegisteredFireBase(error: error.localizedDescription)
                    print(String(describing: error))
                }
            }
        } else  {
            deSetupActivityIndicator()
            showAlertNotEnteredData()
        }
        
    }
    
    private func showAlertNotRegisteredFireBase(error rText: String){
        let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyErrorRegistrationFireBase, comment: ""),
                                      message: rText,
                                      preferredStyle: .alert)
        let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyAlertNotEnteredDataAction, comment: ""),
                                        style: .default)
        alarm.addAction(alarmAction)
        self.present(alarm, animated: true)
    }
    
    private func showAlertNotEnteredData(){
        // логин или пароль не ввели
        let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyAlertNotEnteredDataTitle, comment: ""),
                                      message: NSLocalizedString(LocalizitedKeys.keyAlertNotEnteredDataText, comment: ""),
                                      preferredStyle: .alert)
        let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyAlertNotEnteredDataAction, comment: ""),
                                        style: .default)
        alarm.addAction(alarmAction)
        present(alarm, animated: true)
    }
    private func showAlertNotCorrectDataFireBase(error rText: String){
        let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyErrorLogInFireBase, comment: ""),
                                      message: rText,
                                      preferredStyle: .alert)
        let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyAlertNotCorrectLoginAction, comment: ""),
                                        style: .default)
        alarm.addAction(alarmAction)
        self.present(alarm, animated: true)
    }
    
    private func showAlertNotCorrectData(){
        let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyAlertNotCorrectLoginTitle, comment: ""),
                                      message: NSLocalizedString(LocalizitedKeys.keyAalertNotCorrectLoginText, comment: ""),
                                      preferredStyle: .alert)
        let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyAlertNotCorrectLoginAction, comment: ""),
                                        style: .default)
        alarm.addAction(alarmAction)
        present(alarm, animated: true)
    }
    
    private func showAlertNotAuthUser(){
        // логин или пароль не ввели
        let alarm = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyAlertNotAuthUserForBiometricalEnter,
                                                               comment: ""),
                                      message: NSLocalizedString(LocalizitedKeys.keyAlertNotAuthUserForBiometricalEnterText,
                                                                 comment: ""),
                                      preferredStyle: .alert)
        let alarmAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyAlertNotEnteredDataAction,
                                                                 comment: ""),
                                        style: .default)
        alarm.addAction(alarmAction)
        present(alarm, animated: true)
    }
    
    private func showAlertLoginByBiometricalDone(){
        let alert = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyBiometriaAlertDone, comment: ""),
                                      message: NSLocalizedString(LocalizitedKeys.keyBiometriaAlertDoneText, comment: ""),
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyTimeAlertOk, comment: ""),
                                        style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    private func showAlertNotLoginByBiometrical(text error: String){
        let alert = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyBiometriaAlertError, comment: ""),
                                      message: error,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyTimeAlertOk, comment: ""),
                                        style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    private func setupActivityIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func deSetupActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    @objc private func didShowKeyboard(_ notification: Notification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let logInButtomBottomPointY =
            stackButton.frame.origin.y +
            logInButton.frame.origin.y +
            logInButton.frame.height
            
            let keyboardOriginY = view.frame.height - keyboardHeight
            
            var offSet: CGFloat = CGFloat()
            if keyboardOriginY <= logInButtomBottomPointY {
                offSet = logInButtomBottomPointY - keyboardOriginY + 16
            }
            scrollView.contentOffset = CGPoint(x: 0, y: offSet)
        }
    }
    
    @objc private func didHideKeyBoard(_ notification: Notification){
        hideKeyboard()
    }
}
