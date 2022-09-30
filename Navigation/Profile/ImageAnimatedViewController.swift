//
//  ImageAnimatedViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 05.08.2022.
//

import UIKit

// вью, которое будет с анимацией

class ImageAnimatedViewController: UIViewController {
    
    private lazy var closeButtonAfterShowAvatarImage: CustomButton = {
        let button = CustomButton(title: "",
                                  titleColor: .black,
                                  backgroundButtonColor: .white,
                                  clipsToBoundsOfButton: true,
                                  cornerRadius: 1,
                                  borderWidth: 3,
                                  alphaButton: 0,
                                  borderColor: UIColor.lightGray.cgColor,
                                  autoLayout: false)
        button.setImage(UIImage(named: "xmark.square.fill"), for: .normal)
        button.addTargetForButton = { self.tapOnClose() }
        return button
    }()
    
    // назад вернуться
    @objc private func tapOnClose(){
        // перед уходом показываем анимацию
        // для этого нужно найти коэф уменьшенения
        let finalWidth = 1/(Float(view.frame.width) / 180)
        let finalHeight = 1/(Float(view.frame.height) / 360)
        animationClose(with: finalWidth, and: finalHeight)
        // переход отрабатывает быстрее анимации, нужен таймер
        _ = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(moveBack), userInfo: .none, repeats: false)
    }
    
    @objc private func moveBack(){
        navigationController?.popViewController(animated: false)
    }
    
    private lazy var avatarImageIncrease: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.mainPhoto)
        image.clipsToBounds = true
        image.layer.cornerRadius = 90
        image.layer.borderWidth = 3.0
        image.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        somefunc()
        setupView()
        // нужен коэф увеличения
        let finalWidth = (Float(view.frame.width) / 180)
        let finalHeight = (Float(view.frame.height) / 360)
        // в момент открытия вью запускаем анимацию
        animationIncrease(with: finalWidth, and: finalHeight)
        
    }
    
    private func animationIncrease(with finalWidth: Float, and finalHeight: Float){
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 0.7
            self.avatarImageIncrease.layer.cornerRadius = 0
            self.avatarImageIncrease.transform = CGAffineTransform(scaleX: CGFloat(finalWidth), y: CGFloat(finalHeight))
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {self.closeButtonAfterShowAvatarImage.alpha = 1} completion: { _ in }
        }
    }
    
    private func animationClose(with finalWidth: Float, and finalHeight: Float){
        UIView.animate(withDuration: 1) {
            self.view.alpha = 1
            self.closeButtonAfterShowAvatarImage.alpha = 0
            self.avatarImageIncrease.layer.cornerRadius = 90
            self.avatarImageIncrease.transform = CGAffineTransform(scaleX: CGFloat(finalWidth), y: CGFloat(finalHeight))
        } completion: { _ in  }
    }
    
    private func setupView(){
        view.backgroundColor = .lightGray
        view.addSubview(closeButtonAfterShowAvatarImage)
        view.addSubview(avatarImageIncrease)
        
        NSLayoutConstraint.activate([
            
            closeButtonAfterShowAvatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButtonAfterShowAvatarImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            avatarImageIncrease.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageIncrease.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            avatarImageIncrease.heightAnchor.constraint(equalToConstant: 180),
            avatarImageIncrease.widthAnchor.constraint(equalToConstant: 180)
            
        ])
    }
    
}
