//
//  LogInViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 23.07.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    
    let concurrentQuee = DispatchQueue(label: "queueForPassword",
                                       qos: .userInteractive,
                                       attributes: [.concurrent])
    
    private lazy var logoImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: Constants.logoName)
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackLogoImage: UIStackView = {
        let lStack = UIStackView()
        lStack.layer.borderColor = UIColor.white.cgColor
        lStack.layer.borderWidth = 0.5
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
        email.placeholder = Constants.email
        email.autocapitalizationType = .none
        email.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        return email
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.5
        password.textColor = .black
        password.textAlignment = .left
        password.font = .systemFont(ofSize: 16)
        password.isSecureTextEntry = true
        password.backgroundColor = .systemGray6
        password.placeholder = Constants.password
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
        let button = CustomButton(title: Constants.logInButtonText,
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
        let buttom = CustomButton(title: Constants.registrationNewUser, titleColor: .white, backgroundButtonColor: .specialBlue, clipsToBoundsOfButton: true, cornerRadius: 10, autoLayout: false)
        buttom.addTargetForButton = { self.registerNewUser() }
        return buttom
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        // на вью добавить скролл
        view.addSubview(scrollView)
        // в скролл добавить стеки с полями и кнопкой
        scrollView.addSubview(stackLogoImage)
        scrollView.addSubview(stackTextFields)
        scrollView.addSubview(stackButton)
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
            activityIndicator.centerYAnchor.constraint(equalTo: stackTextFields.centerYAnchor, constant: 26)
            
        ])
    }
    
    @objc private func goToProfileViewController(sender: UIButton) {
        if sender.tag == Constants.logInButtonTap {
            setupActivityIndicator()
            hideKeyboard()
            if ( (emailTextField.text != "") && (passwordTextField.text != "") ) {
                
                let checkerService = CheckerService()
                checkerService.checkCredentials(for: emailTextField.text!, and: passwordTextField.text!) { result in
                    switch result {
                    case .success(let user):
                        self.deSetupActivityIndicator()
                        let goToProfileViewController = ProfileViewController(user: user)
                        goToProfileViewController.modalPresentationStyle = .currentContext
                        self.navigationController?.pushViewController(goToProfileViewController, animated: true)
                        
                    case .failure(let error):
                        self.deSetupActivityIndicator()
                        let alarm = UIAlertController(title: Constants.errorLogInFireBase, message: error.localizedDescription, preferredStyle: .alert)
                        let alarmAction = UIAlertAction(title: Constants.alertNotCorrectLoginAction, style: .default)
                        alarm.addAction(alarmAction)
                        self.present(alarm, animated: true)
                        print(String(describing: error))
                    }
                }
            } else {
                deSetupActivityIndicator()
                // логин или пароль неверный
                let alarm = UIAlertController(title: Constants.alertNotCorrectLoginTitle, message: Constants.alertNotCorrectLoginText, preferredStyle: .alert)
                let alarmAction = UIAlertAction(title: Constants.alertNotCorrectLoginAction, style: .default)
                alarm.addAction(alarmAction)
                present(alarm, animated: true)
            }} else {
                deSetupActivityIndicator()
                // логин или пароль не ввели
                let alarm = UIAlertController(title: Constants.alertNotEnteredDataTitle, message: Constants.alertNotEnteredDataText, preferredStyle: .alert)
                let alarmAction = UIAlertAction(title: Constants.alertNotEnteredDataAction, style: .default)
                alarm.addAction(alarmAction)
                present(alarm, animated: true)
            }
    }
    
    @objc private func registerNewUser(){
        setupActivityIndicator()
        hideKeyboard()
        // если поля заполнены, то можно идти дальше
        if ( (emailTextField.text != "") && (passwordTextField.text != "") ) {
            
            let checkerService = CheckerService()
            checkerService.signUp(for: emailTextField.text!, and: passwordTextField.text!) { result in
                switch result {
                case .success(let user):
                    self.deSetupActivityIndicator()
                    let goToProfileViewController = ProfileViewController(user: user)
                    goToProfileViewController.modalPresentationStyle = .currentContext
                    self.navigationController?.pushViewController(goToProfileViewController, animated: true)
                case .failure(let error):
                    self.deSetupActivityIndicator()
                    let alarm = UIAlertController(title: Constants.errorRegistrationFireBase, message: error.localizedDescription, preferredStyle: .alert)
                    let alarmAction = UIAlertAction(title: Constants.alertNotEnteredDataAction, style: .default)
                    alarm.addAction(alarmAction)
                    self.present(alarm, animated: true)
                    print(String(describing: error))
                }
            }
        } else  {
            deSetupActivityIndicator()
            // логин или пароль не ввели
            let alarm = UIAlertController(title: Constants.alertNotEnteredDataTitle, message: Constants.alertNotEnteredDataText, preferredStyle: .alert)
            let alarmAction = UIAlertAction(title: Constants.alertNotEnteredDataAction, style: .default)
            alarm.addAction(alarmAction)
            present(alarm, animated: true)
        }
        
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
