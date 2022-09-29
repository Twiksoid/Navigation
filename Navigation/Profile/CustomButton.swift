//
//  CustomButton.swift
//  Navigation
//
//  Created by Nikita Byzov on 29.09.2022.
//

import UIKit

class CustomButton: UIButton {
    
    var title: String
    var titleColor: UIColor
    var buttonSystemName: String
    var backgroundButtonColor: UIColor
    var clipsToBoundsOfButton: Bool
    var cornerRadius: CGFloat
    var borderWidth: CGFloat
    var alphaButton: CGFloat
    var borderColor: CGColor
    var autoLayout: Bool
    
    var targetName: String
    var targetState: UIControl.Event
    
    var addTarget = {}
    
    init(title: String, titleColor: UIColor, buttonSystemName: String, backgroundButtonColor: UIColor, clipsToBoundsOfButton: Bool, cornerRadius: CGFloat, borderWidth: CGFloat, alphaButton: CGFloat, borderColor: CGColor, targetName: String, targetState: UIControl.Event, autoLayout: Bool) {
        self.title = title
        self.titleColor = titleColor
        self.buttonSystemName = buttonSystemName
        self.backgroundButtonColor = backgroundButtonColor
        self.clipsToBoundsOfButton = clipsToBoundsOfButton
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.alphaButton = alphaButton
        self.borderColor = borderColor
        self.targetName = targetName
        self.targetState = targetState
        self.autoLayout = autoLayout
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(){
        tintColor = titleColor
        setImage(UIImage(systemName: buttonSystemName), for: .normal)
        setTitle(title, for: .normal)
        backgroundColor = backgroundButtonColor
        clipsToBounds = clipsToBoundsOfButton
        alpha = alphaButton
        layer.borderColor = borderColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        addTarget(self, action: #selector(buttonTapped), for: targetState)
        translatesAutoresizingMaskIntoConstraints = autoLayout
    }
    
    @objc private func buttonTapped(){
        if targetName == "tapOnClose" {
        }
    }
}
