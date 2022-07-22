//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Nikita Byzov on 12.07.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    var globalStatusText: String = ""
    
    private lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: Constants.mainPhoto)
        // скруглить изображение
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemCyan
        // радиус скругления
        imageView.layer.cornerRadius = 90
        // толщина рамки
        imageView.layer.borderWidth = 3.0
        // цвет рамки
        imageView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.tag = Constants.avatarImageViewTap
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleTextField: UITextField = {
        let titleField = UITextField()
        titleField.textColor = .black
        titleField.font = .boldSystemFont(ofSize: 18)
        titleField.text = Constants.titleTextField
        titleField.tag = Constants.titleTextFieldTap
        titleField.isUserInteractionEnabled = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    private lazy var statusTextField: UITextField = {
        let statusField = UITextField()
        statusField.textColor = .gray
        statusField.font = .systemFont(ofSize: 14)
        statusField.text = Constants.statusTextField
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
        enterStatusField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        enterStatusField.backgroundColor = .white
        enterStatusField.textColor = .black
        enterStatusField.font = .systemFont(ofSize: 15)
        enterStatusField.text = Constants.enteringStatusTextField
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
    
    private lazy var showStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle(Constants.showStatusButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4.0
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset.width = 4.0
        button.layer.shadowOffset.height = 4.0
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.tag = Constants.showStatusButtonTap
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(self.setStatus), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.addSubview(avatarImageView)
        self.addSubview(titleTextField)
        self.addSubview(statusTextField)
        self.addSubview(enteringStatusTextField)
        self.addSubview(showStatusButton)
        
        let avatarImageViewConstraint = self.avatarImageViewConstraint()
        let titleTextFieldConstraint = self.titleTextFieldConstraint()
        let statusTextFieldConstraint = self.statusTextFieldConstraint()
        let enteringStatusTextFieldConstraint = self.enteringStatusTextFieldConstraint()
        let showStatusButtonConstraint = self.showStatusButtonConstraint()
        
        NSLayoutConstraint.activate(avatarImageViewConstraint +
                                    titleTextFieldConstraint +
                                    statusTextFieldConstraint +
                                    enteringStatusTextFieldConstraint +
                                    showStatusButtonConstraint
        )
    }
    
    private func avatarImageViewConstraint() -> [NSLayoutConstraint]{
        let avatarImageViewConstraintTop = avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        let avatarImageViewConstraintLeft = avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let avatarImageViewConstraintHeight = avatarImageView.heightAnchor.constraint(equalToConstant: 180)
        let avatarImageViewConstraintWidth = avatarImageView.widthAnchor.constraint(equalToConstant: 180)
        return [avatarImageViewConstraintTop, avatarImageViewConstraintLeft, avatarImageViewConstraintHeight, avatarImageViewConstraintWidth]
    }
    
    private func titleTextFieldConstraint() -> [NSLayoutConstraint]{
        let titleTextFieldConstraintTop = titleTextField.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: 27)
        let titleTextFieldConstraintLeft = titleTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20)
        let titleTextFieldConstraintHeight = titleTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 20)
        let titleTextFieldConstraintWidth = titleTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 110)
        return [titleTextFieldConstraintTop,titleTextFieldConstraintLeft, titleTextFieldConstraintHeight, titleTextFieldConstraintWidth]
    }
    
    private func statusTextFieldConstraint() -> [NSLayoutConstraint]{
        let statusTextFieldConstraintTop =  statusTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 34)
        let statusTextFieldConstraintLeft = statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20)
        let statusTextFieldConstraintHeight = statusTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 20)
        let statusTextFieldConstraintWidth = statusTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
        return [statusTextFieldConstraintTop, statusTextFieldConstraintLeft, statusTextFieldConstraintHeight,  statusTextFieldConstraintWidth]
    }
    
    private func enteringStatusTextFieldConstraint() -> [NSLayoutConstraint]{
        let enteringStatusTextFieldConstraintTop = enteringStatusTextField.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16)
        let enteringStatusTextFieldConstraintLeft = enteringStatusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16)
        let enteringStatusTextFieldConstraintRight = enteringStatusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        let enteringStatusTextFieldConstraintBottom = enteringStatusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -16)
        let enteringStatusTextFieldConstraintHeight = enteringStatusTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 40)
        let enteringStatusTextFieldConstraintWidth = enteringStatusTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
        return [enteringStatusTextFieldConstraintTop, enteringStatusTextFieldConstraintLeft, enteringStatusTextFieldConstraintRight, enteringStatusTextFieldConstraintBottom, enteringStatusTextFieldConstraintHeight, enteringStatusTextFieldConstraintWidth]
    }
    
    private func showStatusButtonConstraint() -> [NSLayoutConstraint]{
        let showStatusButtonConstraintTop = showStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16)
        let showStatusButtonConstraintLeft = showStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let showStatusButtonConstraintRight = showStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        let showStatusButtonConstraintHeight = showStatusButton.heightAnchor.constraint(equalToConstant: 50)
        let showStatusButtonConstraintWidth = showStatusButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        let showStatusButtonConstraintBottom = showStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        return [showStatusButtonConstraintTop, showStatusButtonConstraintLeft, showStatusButtonConstraintRight, showStatusButtonConstraintBottom,  showStatusButtonConstraintHeight, showStatusButtonConstraintWidth]
    }
}
