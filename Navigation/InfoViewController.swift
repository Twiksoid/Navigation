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
        
        button.setTitle(NSLocalizedString(LocalizitedKeys.keyShowAlertInfoView, comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    private lazy var labelForAPIFieldTitle: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(LocalizitedKeys.keyLoadingText, comment: "")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelForAPIFieldOrbitalPeriod: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(LocalizitedKeys.keyLoadingText, comment: "")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView(){
        
        view.backgroundColor = .white
        view.addSubview(labelForAPIFieldTitle)
        view.addSubview(labelForAPIFieldOrbitalPeriod)
        NSLayoutConstraint.activate([
            labelForAPIFieldTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelForAPIFieldTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelForAPIFieldTitle.widthAnchor.constraint(equalToConstant: view.bounds.width/2),
            labelForAPIFieldTitle.heightAnchor.constraint(equalToConstant: view.bounds.height/10),
            
            labelForAPIFieldOrbitalPeriod.topAnchor.constraint(equalTo: labelForAPIFieldTitle.bottomAnchor, constant: 10),
            labelForAPIFieldOrbitalPeriod.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelForAPIFieldOrbitalPeriod.widthAnchor.constraint(equalToConstant: view.bounds.width/2),
            labelForAPIFieldOrbitalPeriod.heightAnchor.constraint(equalToConstant: view.bounds.height/10)
        ])
        
    }
    
    private func setupLabelForAPIFieldTitle(){
        
        // Вызываем обращение к API, задача 1 , Домашнее задание 2
        NetworkService.requestAnotherAPI(for: "https://jsonplaceholder.typicode.com/todos/10") { titleValue in
            DispatchQueue.main.async {
                self.labelForAPIFieldTitle.text = NSLocalizedString(LocalizitedKeys.keyTextFiledValue, comment: "") + titleValue!
                self.labelForAPIFieldTitle.textColor = .black
            }
        }
        
    }
    
    private func setupLabelForAPIFieldOrbitalPeriod(){
        
        // Вызываем обращение к API, задача 2 , Домашнее задание 2
        NetworkService.requestPlanetAPI(for: "https://swapi.dev/api/planets/1") { orbitalPeriod in
            
            DispatchQueue.main.async {
                self.labelForAPIFieldOrbitalPeriod.text = NSLocalizedString(LocalizitedKeys.keyPeriodPlanets, comment: "") + orbitalPeriod!
                self.labelForAPIFieldOrbitalPeriod.textColor = .black
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLabelForAPIFieldTitle()
        setupLabelForAPIFieldOrbitalPeriod()
        //view.addSubview(self.alertButton)
        //alertButton.center = self.view.center
    }
    
    @objc private func showAlert(){
        let alertController = UIAlertController(title: NSLocalizedString(LocalizitedKeys.keyTitilePlanet, comment: ""),
                                                message: NSLocalizedString(LocalizitedKeys.keyTextMessagaPlanet, comment: ""),
                                                preferredStyle: .alert)
        let alertActionFirst = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyActionPlanetOne, comment: ""), style: .default) {_ in print("Нажата кнопка 'Действие один'")}
        let alertActionSecond = UIAlertAction(title: NSLocalizedString(LocalizitedKeys.keyActionPlanetTwo, comment: "") , style: .cancel) {_ in print("Нажата кнопка 'Действие два'")}
        
        alertController.addAction(alertActionFirst)
        alertController.addAction(alertActionSecond)
        
        self.present(alertController, animated: true)
    }
}
