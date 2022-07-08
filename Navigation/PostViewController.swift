//
//  PostViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.07.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        
        // создаю новый объект в верхнем баре
        let info = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(openInfo))
        
        // добавляю его в доступные к выводу
        navigationItem.rightBarButtonItems = [info]
        
    }
    
    @objc private func openInfo(){
        let infoButton = InfoViewController()
        infoButton.modalPresentationStyle = .popover
        self.present(infoButton, animated: true)
    }
    
}
