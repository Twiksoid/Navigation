//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.08.2022.
//

import UIKit

// кастомная ячейка на экране профиля с миниатюрами изображений
class PhotosTableViewCell: UITableViewCell {
    
    private lazy var miniTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = NSLocalizedString(LocalizitedKeys.keyNameForMiniCollectionPhotos, comment: "")
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.forward")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var miniImage1: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var miniImage2: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var miniImage3: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var miniImage4: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.addSubview(miniTitle)
        //contentView.addSubview(imageMini)
        contentView.addSubview(imageArrow)
        contentView.addSubview(miniImage1)
        contentView.addSubview(miniImage2)
        contentView.addSubview(miniImage3)
        contentView.addSubview(miniImage4)
        
        let widthImage = (UIScreen.main.bounds.width-48)/4
        let heightImage = widthImage
        
        NSLayoutConstraint.activate([
            miniTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            miniTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            miniImage1.topAnchor.constraint(equalTo: miniTitle.bottomAnchor, constant: 12),
            miniImage1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            miniImage1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            miniImage1.widthAnchor.constraint(equalToConstant: widthImage),
            miniImage1.heightAnchor.constraint(equalToConstant: heightImage),
            
            miniImage2.topAnchor.constraint(equalTo: miniTitle.bottomAnchor, constant: 12),
            miniImage2.leadingAnchor.constraint(equalTo: miniImage1.trailingAnchor, constant: 8),
            miniImage2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            miniImage2.widthAnchor.constraint(equalToConstant: widthImage),
            miniImage2.heightAnchor.constraint(equalToConstant: heightImage),
            
            miniImage3.topAnchor.constraint(equalTo: miniTitle.bottomAnchor, constant: 12),
            miniImage3.leadingAnchor.constraint(equalTo: miniImage2.trailingAnchor, constant: 8),
            miniImage3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            miniImage3.widthAnchor.constraint(equalToConstant: widthImage),
            miniImage3.heightAnchor.constraint(equalToConstant: heightImage),
            
            miniImage4.topAnchor.constraint(equalTo: miniTitle.bottomAnchor, constant: 12),
            miniImage4.leadingAnchor.constraint(equalTo: miniImage3.trailingAnchor, constant: 8),
            miniImage4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            miniImage4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            miniImage4.widthAnchor.constraint(equalToConstant: widthImage),
            miniImage4.heightAnchor.constraint(equalToConstant: heightImage),
            
            imageArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            imageArrow.centerYAnchor.constraint(equalTo: miniTitle.centerYAnchor)
            
        ])
        
    }
    
    func setupMiniCollection(for name: [String]){
        for i in name {
            if i == "1.jpg" {
                miniImage1.image = UIImage(named: i)
            } else if i == "2.jpg" {miniImage2.image = UIImage(named: i)
            } else if i == "3.jpg" {
                miniImage3.image = UIImage(named: i)
            } else if i == "4.jpg" {
                miniImage4.image = UIImage(named: i)
            }
        }}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
