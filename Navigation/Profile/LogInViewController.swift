//
//  LogInViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 23.07.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
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
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.tag = Constants.logInButtonTap
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle(Constants.logInButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: Constants.pixelBlue), for: .normal)
        button.addTarget(self, action: #selector(goToProfileViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackButton: UIStackView = {
        let bStack = UIStackView()
        bStack.distribution = .fillEqually
        bStack.axis = .vertical
        bStack.spacing = 0
        bStack.translatesAutoresizingMaskIntoConstraints = false
        bStack.addArrangedSubview(logInButton)
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
            stackButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func goToProfileViewController(sender: UIButton){
        if sender.tag == Constants.logInButtonTap {
            hideKeyboard()
            let goToProfileViewController = ProfileViewController()
            goToProfileViewController.modalPresentationStyle = .currentContext
            self.present(goToProfileViewController, animated: true)
        }
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
