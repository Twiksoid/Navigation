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
        var imageView = UIImageView(frame: CGRect(x: 16, y: 40, width: 170, height: 170))
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
        let titleField = UITextField(frame: CGRect(x: 190, y: 60, width: 130, height: 20))
        titleField.textColor = .black
        titleField.font = .boldSystemFont(ofSize: 18)
        titleField.text = Constants.titleTextField
        titleField.tag = Constants.titleTextFieldTap
        titleField.isUserInteractionEnabled = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()

    private lazy var statusTextField: UITextField = {
        let statusField = UITextField(frame: CGRect(x: 190, y: 150, width: 170, height: 20))
        statusField.textColor = .gray
        statusField.font = .systemFont(ofSize: 14)
        statusField.text = Constants.statusTextField
        statusField.tag = Constants.statusTextFieldTap
        statusField.isUserInteractionEnabled = false
        statusField.translatesAutoresizingMaskIntoConstraints = false
        return statusField
    }()

    private lazy var enteringStatusTextField: UITextField = {
        let enterStatusField = UITextField(frame: CGRect(x: 190, y: 180, width: 170, height: 40))
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
        let button = UIButton(frame: CGRect(x: 16, y: 320, width: 380, height: 50))
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
        let AIVCTop = avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        let AIVCLeft = avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let AIVCHeight = avatarImageView.heightAnchor.constraint(equalToConstant: 180)
        let AIVCWidth = avatarImageView.widthAnchor.constraint(equalToConstant: 180)
        return [AIVCTop, AIVCLeft, AIVCHeight, AIVCWidth]
    }

 private func titleTextFieldConstraint() -> [NSLayoutConstraint]{
     let TTFCTop = titleTextField.safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor, constant: 27)
     let TTFCLeft = titleTextField.leadingAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20)
     let TTFCHeight = titleTextField.heightAnchor.constraint(equalToConstant: 20)
     let TTFCWidth = titleTextField.widthAnchor.constraint(equalToConstant: 130)
     return [TTFCTop,TTFCLeft, TTFCHeight, TTFCWidth]
    }

    private func statusTextFieldConstraint() -> [NSLayoutConstraint]{
      let STFCTop =  statusTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 34)
      let STFCLeft = statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20)
        let STFCHeight = statusTextField.heightAnchor.constraint(equalToConstant: 20)
        let STFCWidth = statusTextField.widthAnchor.constraint(equalToConstant: 170)
        return [STFCTop, STFCLeft, STFCHeight, STFCWidth]
    }

    private func enteringStatusTextFieldConstraint() -> [NSLayoutConstraint]{
       let ESTFCTop = enteringStatusTextField.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16)
       let ESTFCLeft = enteringStatusTextField.leadingAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16)
       let ESTFCRight = enteringStatusTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
       let ESTFCBottom = enteringStatusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -16)
      let ESTFCHeight = enteringStatusTextField.heightAnchor.constraint(equalToConstant: 40)
        let ESTFCWidth = enteringStatusTextField.widthAnchor.constraint(equalToConstant: 170)
        return [ESTFCTop, ESTFCLeft, ESTFCRight, ESTFCBottom, ESTFCHeight, ESTFCWidth]
    }

    private func showStatusButtonConstraint() -> [NSLayoutConstraint]{
    let SSBTop = showStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16)
    let SSBLeft = showStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
    let SSBRight = showStatusButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        let SSBHeight = showStatusButton.heightAnchor.constraint(equalToConstant: 50)
          let SSBWidth = showStatusButton.widthAnchor.constraint(equalToConstant: 380)
    return [SSBTop, SSBLeft, SSBRight, SSBHeight, SSBWidth]
    }
}
