//
//  RootViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.07.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var button1: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 35))
        button.backgroundColor = .lightGray
        button.setTitle("Показать пост 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.showPost), for: .touchUpInside)
        return button
    }()

    private lazy var button2: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 35))
        button.backgroundColor = .systemTeal
        button.setTitle("Показать пост 2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.showPost), for: .touchUpInside)
        return button
    }()

    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(frame: CGRect(x: 100, y: 100, width: 140, height: 100))
        vStack.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        vStack.alignment = .center
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.distribution = .fillEqually
        vStack.addArrangedSubview(button1)
        vStack.addArrangedSubview(button2)
        return vStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.vStack)
        self.vStack.center = self.view.center
        
    }
    
    @objc private func showPost(){
        let postScene = PostViewController()
        self.navigationController?.pushViewController(postScene, animated: true)
        postScene.title = post.title
    }
    
}

var post = Post(title: "Поменял текст в заголовке")
