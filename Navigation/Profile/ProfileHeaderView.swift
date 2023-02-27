//
//  CustomHeaderView.swift
//  Navigation
//
//  Created by Nikita Byzov on 27.07.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import RealmSwift

class ProfileHeaderView: UITableViewHeaderFooterView, UIGestureRecognizerDelegate {
    
    var globalStatusText: String = ""
    weak var delegateExit: ProfileViewController?
    
    private lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: Constants.mainPhoto)
        // скруглить изображение
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        // радиус скругления
        imageView.layer.cornerRadius = 90
        // толщина рамки
        imageView.layer.borderWidth = 0.0
        // цвет рамки
        //imageView.layer.borderColor = (UIColor.createColor(lightMode: .white, darkMode: .black)).cgColor
        imageView.tag = Constants.avatarImageViewTap
        // позволяем кнопке быть активной
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleTextField: UITextField = {
        let titleField = UITextField()
        titleField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        titleField.font = .boldSystemFont(ofSize: 18)
        titleField.text = NSLocalizedString(LocalizedKeys.keyTitleTextField, comment: "")
        titleField.tag = Constants.titleTextFieldTap
        titleField.isUserInteractionEnabled = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    private lazy var statusTextField: UILabel = {
        let statusField = UILabel()
        statusField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        statusField.numberOfLines = 0
        statusField.font = .systemFont(ofSize: 14)
        statusField.text = NSLocalizedString(LocalizedKeys.keyStatusTextField, comment: "")
        statusField.tag = Constants.statusTextFieldTap
        statusField.isUserInteractionEnabled = false
        statusField.translatesAutoresizingMaskIntoConstraints = false
        return statusField
    }()
    
    private lazy var enteringStatusTextField: UITextField = {
        let enterStatusField = UITextField()
        // Чтобы был отступ при вводе текста
        enterStatusField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        enterStatusField.layer.cornerRadius = 12.0
        enterStatusField.layer.borderWidth = 1.0
        enterStatusField.layer.borderColor = (UIColor.createColor(lightMode: .black, darkMode: .white)).cgColor
        enterStatusField.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .white)
        enterStatusField.textColor = UIColor.createColor(lightMode: .black, darkMode: .black)
        enterStatusField.font = .systemFont(ofSize: 15)
        enterStatusField.text = ""
        enterStatusField.tag = Constants.enteringStatusTextFieldTap
        enterStatusField.addTarget(self, action: #selector(self.statusTextChanged), for: .editingChanged)
        enterStatusField.translatesAutoresizingMaskIntoConstraints = false
        return enterStatusField
    }()
    
    @objc private func statusTextChanged(){
        var statusText: String
        if (enteringStatusTextField.text != nil || enteringStatusTextField.text?.isEmpty == false) {
            statusText = enteringStatusTextField.text!
            globalStatusText = statusText
            print(statusText)
        } else {
            print("I can not take status, because its nil")
        }
        
    }
    
    private lazy var showStatusButton: CustomButton = {
        let button = CustomButton(title: LocalizedKeys.keyShowStatusButton,
                                  titleColor: UIColor.createColor(lightMode: .black, darkMode: .white),
                                  backgroundButtonColor: UIColor(named: "AccentColor")!,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 4, autoLayout: false)
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset.width = 4.0
        button.layer.shadowOffset.height = 4.0
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.tag = Constants.showStatusButtonTap
        button.isUserInteractionEnabled = true
        button.addTargetForButton = { self.setStatus(sender: button) }
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func setStatus(sender: UIButton){
        if sender.tag == Constants.showStatusButtonTap {
            if enteringStatusTextField.text?.isEmpty == false,
               enteringStatusTextField.text != nil {
                statusTextField.text = globalStatusText
            } else {
                print("This field is empty")
            }
            // убираем клавиатуру, если вызывали
            endEditing(true)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
//    @objc func imagePressed(){
//        let vc = ImageAnimatedViewController()
//        delegate?.navigationController?.pushViewController(vc, animated: false)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка пользовательской вью под зашедшего
    func setupHeader(for user: User?){
        avatarImageView.image = user?.photo
        statusTextField.text = user?.status
        titleTextField.text = user?.fullName
    }
    
    @objc private func exitButtonTapped(){
        // ищем авторизованного пользователя в базе
        // по идее пользователь всегда будет один
        
        let realm = try! Realm()
        let authUser = realm.objects(AuthorizationModel.self).first(where: { $0.isLogin == true } )
        if authUser != nil { try! realm.write { authUser!.isLogin = false } }
        // тут бы через слушателя сделать, но пока можно так оставить
        // суть - мы сделали разлогин пользователя и просим его закрыть приложение, чтобы применилось
        delegateExit?.showAlertRestartApp()
    }
    
    private func setupView(){
        self.addSubview(avatarImageView)
        self.addSubview(titleTextField)
        self.addSubview(statusTextField)
        self.addSubview(enteringStatusTextField)
        self.addSubview(showStatusButton)
        addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            
            exitButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            exitButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 26),
            
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 180),
            avatarImageView.widthAnchor.constraint(equalToConstant: 180),
            
            titleTextField.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            titleTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            titleTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            titleTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 110),
            
            statusTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            enteringStatusTextField.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            enteringStatusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            enteringStatusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            enteringStatusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -16),
            enteringStatusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            showStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            showStatusButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            // потому что тень, чтобы визуально кнопка была внутри вью, а не выходила за него
            showStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)])
    }
}
