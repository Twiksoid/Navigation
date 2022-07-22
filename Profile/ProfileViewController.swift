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
        self.profileView.frame = CGRect(x: 0,
                                        y: 100,
                                        width: self.view.bounds.width,
                                        height: self.view.bounds.height)
    }
    
    private lazy var newButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 450, width: 380, height: 50))
        button.backgroundColor = .systemBlue
        button.setTitle(Constants.newButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4.0
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.tag = Constants.newButtonTap
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        view.addSubview(newButton)
        
        // настройка Constrait
        let profileViewConstrait = self.profileViewConstraint()
        let newButtonConstraint = self.newButtonConstraint()
        NSLayoutConstraint.activate(profileViewConstrait +
                                    newButtonConstraint)
        
    }
    
    private func profileViewConstraint() -> [NSLayoutConstraint] {
        let profileViewConsttaintTop = NSLayoutConstraint(item: self.profileView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0)
        let profileViewConsttaintLeft = self.profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let profileViewConsttaintRight = self.profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let profileViewConsttaintHeight = self.profileView.heightAnchor.constraint(equalToConstant: 220)
        return [profileViewConsttaintTop,profileViewConsttaintLeft,profileViewConsttaintRight,profileViewConsttaintHeight]
    }
    
    private func newButtonConstraint() -> [NSLayoutConstraint]{
        let NBCLeft = newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let NBCRigt = newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let NBCBottom = NSLayoutConstraint(item: self.newButton, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)
        let NBCHHeight = self.newButton.heightAnchor.constraint(equalToConstant: 50)
        //  let NBCHWidht = self.newButton.widthAnchor.constraint(equalToConstant: self.view.frame.width)
        return [NBCLeft, NBCRigt, NBCBottom, NBCHHeight]//, NBCHWidht]
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
