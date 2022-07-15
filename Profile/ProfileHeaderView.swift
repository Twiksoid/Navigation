//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Nikita Byzov on 12.07.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    var globalStatusText: String = ""

    lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView(frame: CGRect(x: 16, y: 40, width: 170, height: 170))
        imageView.image = UIImage(named: Pictures.mainPhoto.rawValue)
        // скруглить изображение
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemCyan
        // радиус скругления
        imageView.layer.cornerRadius = 90
        // толщина рамки
        imageView.layer.borderWidth = 3.0
        // цвет рамки
        imageView.layer.borderColor = colorWhite
        imageView.tag = Tags.avatarImageView.rawValue
        return imageView
    }()

    lazy var titleTextField: UITextField = {
        let titleField = UITextField(frame: CGRect(x: 150, y: 60, width: 130, height: 20))
        titleField.textColor = .black
        titleField.font = .boldSystemFont(ofSize: 18)
        titleField.text = StatusNames.titleTextField.rawValue
        titleField.tag = Tags.titleTextField.rawValue
        titleField.isUserInteractionEnabled = false
        return titleField
    }()

    lazy var statusTextField: UITextField = {
        let statusField = UITextField(frame: CGRect(x: 150, y: 150, width: 170, height: 20))
        statusField.textColor = .gray
        statusField.font = .systemFont(ofSize: 14)
        statusField.text = StatusNames.statusTextField.rawValue
        statusField.tag = Tags.statusTextField.rawValue
        statusField.isUserInteractionEnabled = false
        return statusField
    }()

    lazy var enteringStatusTextField: UITextField = {
        let enterStatusField = UITextField(frame: CGRect(x: 150, y: 110, width: 170, height: 40))
        // Чтобы был отступ при вводе текста
        enterStatusField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        enterStatusField.layer.cornerRadius = 12.0
        enterStatusField.layer.borderWidth = 1.0
        enterStatusField.layer.borderColor = colorBlack
        enterStatusField.backgroundColor = .white
        enterStatusField.textColor = .black
        enterStatusField.font = .systemFont(ofSize: 15)
        enterStatusField.text = StatusNames.enteringStatusTextField.rawValue
        enterStatusField.tag = Tags.enteringStatusTextField.rawValue
        enterStatusField.addTarget(self, action: #selector(self.statusTextChanged), for: .editingChanged)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(avatarImageView)
        self.addSubview(titleTextField)
        self.addSubview(statusTextField)
        self.addSubview(enteringStatusTextField)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
