//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 12.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // создаю представление profileView
    private lazy var profileView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.backgroundColor = .lightGray
        return profileHeaderView
    }()
    
    // задаю представлению тот же самый размер, что и у profileView
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.profileView.frame = CGRect(x: 0,
                                        y: 100,
                                        width: self.view.bounds.width,
                                        height: self.view.bounds.height)
    }
    
    private lazy var showStatusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 320, width: 380, height: 50))
        button.backgroundColor = .systemBlue
        button.setTitle(StatusNames.showStatusButton.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4.0
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOffset.width = 4.0
        button.layer.shadowOffset.height = 4.0
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.tag = Tags.showStatusButton.rawValue
        button.addTarget(self, action: #selector(self.setStatus), for: .touchUpInside)
        return button
    }()
    
    @objc private func setStatus(sender: UIButton){
        if sender.tag == Tags.showStatusButton.rawValue {
            if profileView.enteringStatusTextField.text != "" && profileView.enteringStatusTextField.text != nil {
                profileView.statusTextField.text = profileView.globalStatusText
            } else {
                print("This field is empty")
            }
            // убираем клавиатуру, если вызывали
            view.endEditing(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // настраиваем базовые вью
        setupView()
        // настраиваем вью, если темная тема
        isCurrentThemeDark()
        // настраиваем констрейты 
        setupConstraints()
    }
    
    func setupView(){
        // чтобы закрасить основное вью
        view.backgroundColor = .white
        // чтобы большим было
        // navigationController?.navigationBar.prefersLargeTitles = true
        // чтобы автоматом подбирало размер
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = StatusNames.viewTitle.rawValue
        
        view.addSubview(profileView)
        view.addSubview(showStatusButton)
    }
    
    func setupConstraints(){
        // отключить дефолтные CONSTRAINTs и создать свои, активировать их
        profileView.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        profileView.avatarImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 16).isActive = true
        profileView.avatarImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        profileView.avatarImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        profileView.avatarImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        profileView.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        profileView.titleTextField.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 27).isActive = true
        profileView.titleTextField.leftAnchor.constraint(equalTo: profileView.avatarImageView.rightAnchor, constant: 20).isActive = true
        
        profileView.statusTextField.translatesAutoresizingMaskIntoConstraints = false
        profileView.statusTextField.topAnchor.constraint(equalTo: profileView.titleTextField.bottomAnchor, constant: 34).isActive = true
        profileView.statusTextField.leftAnchor.constraint(equalTo: profileView.avatarImageView.rightAnchor, constant: 20).isActive = true
        
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        showStatusButton.topAnchor.constraint(equalTo: profileView.avatarImageView.bottomAnchor, constant: 16).isActive = true
        showStatusButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        showStatusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true

        profileView.enteringStatusTextField.translatesAutoresizingMaskIntoConstraints = false
        profileView.enteringStatusTextField.topAnchor.constraint(equalTo: profileView.statusTextField.bottomAnchor, constant: 16).isActive = true
        profileView.enteringStatusTextField.leftAnchor.constraint(equalTo: profileView.avatarImageView.rightAnchor, constant: 16).isActive = true
        profileView.enteringStatusTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        profileView.enteringStatusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -16).isActive = true
        profileView.enteringStatusTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    // Для темной темы нужен костыль, чтобы нормально отображался верхний бар (где время, заряд батареи и тд)
    public func isCurrentThemeDark(){
        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark) {
            print("Current Theme is dark")
            // меняю цвет вью на черный
            view.backgroundColor = .black
            // меняю "Profile" в NavigationBar на белый
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 20)!]
            // меняю фон NavigationBar на черный
            navigationController?.navigationBar.backgroundColor = .black
        } else {
            print("Current Theme is not dark or I can not recognize it")
        }
    }
}


