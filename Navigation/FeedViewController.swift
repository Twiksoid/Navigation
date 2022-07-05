//
//  RootViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.07.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 35))
        button.backgroundColor = .systemTeal
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.addTarget(self, action: #selector(self.showPost), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.button)
        self.button.center = self.view.center
        
    }
    
    @objc private func showPost(){
        let postScene = PostViewController()
        self.navigationController?.pushViewController(postScene, animated: true)
        postScene.title = post.title
    }
    
}

var post = Post(title: "Поменял текст в заголовке")
