//
//  InfoViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.07.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 35))
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(self.showAlert), for: .touchUpInside)
        
        button.setTitle("Показать Алерт", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.alertButton)
        self.alertButton.center = self.view.center
    }
    
    @objc private func showAlert(){
        let alertController = UIAlertController(title: "Уведомление", message: "Нажмите на одну из кнопок", preferredStyle: .alert)
        let alertActionFirst = UIAlertAction(title: "Действие один", style: .default) {_ in print("Нажата кнопка 'Действие один'")}
        let alertActionSecond = UIAlertAction(title: "Действие два", style: .cancel) {_ in print("Нажата кнопка 'Действие два'")}
        
        alertController.addAction(alertActionFirst)
        alertController.addAction(alertActionSecond)
        
        self.present(alertController, animated: true)
    }
}
