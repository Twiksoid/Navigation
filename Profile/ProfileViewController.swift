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
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    // задаю представлению тот же самый размер, что и у profileView
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //self.profileView.frame = CGRect()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // настраиваем базовые вью
        setupView()
        // настраиваем вью, если темная тема
        isCurrentThemeDark()
    }
    
    func setupView(){
        // чтобы закрасить основное вью
        view.backgroundColor = .white
        // чтобы большим было
        // navigationController?.navigationBar.prefersLargeTitles = true
        // чтобы автоматом подбирало размер
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = Constants.viewTitle
        view.addSubview(profileView)
        
        // настройка Constrait
        NSLayoutConstraint.activate([
            self.profileView.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor),
            self.profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.profileView.heightAnchor.constraint(equalToConstant: 267)
        ])
    }
    
    // Для темной темы нужен костыль, чтобы нормально отображался верхний бар (где время, заряд батареи и тд)
     func isCurrentThemeDark(){
        if (traitCollection.userInterfaceStyle == UIUserInterfaceStyle.dark) {
            print("Current Theme is dark")
            // меняю цвет вью на серый
            view.backgroundColor = .lightGray
            // меняю "Profile" в NavigationBar на черный
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 20)!]
            // меняю фон NavigationBar на белый
            navigationController?.navigationBar.backgroundColor = .white
        } else {
            print("Current Theme is not dark or I can not recognize it")
        }
    }
}
