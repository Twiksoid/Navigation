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
