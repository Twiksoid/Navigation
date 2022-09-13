//
//  CustomTableViewCell.swift
//  Navigation
//
//  Created by Nikita Byzov on 27.07.2022.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    private lazy var titlePostLabel: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 20)
        title.numberOfLines = 2
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var imagePostView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var descriptionPostLabel: UILabel = {
        let description = UILabel()
        description.font = .systemFont(ofSize: 14)
        description.textColor = .systemGray
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var likePostLabel: UILabel = {
        let like = UILabel()
        like.font = .systemFont(ofSize: 16)
        like.textColor = .black
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    private lazy var viewPostLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var authorPostLabel: UILabel = {
        let author = UILabel()
        author.font = .systemFont(ofSize: 16)
        author.textColor = .black
        author.translatesAutoresizingMaskIntoConstraints = false
        return author
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(for model: Post){
        titlePostLabel.text = model.title
        authorPostLabel.text = model.author
        descriptionPostLabel.text = model.description
        // тут обрабатываем фото и возвращаем его в поле
        ImageProcessor().processImage(sourceImage: UIImage(named: model.image)!, filter: .fade) { imagePostView.image = $0 }
        likePostLabel.text = "Likes: \(model.likes)"
        viewPostLabel.text = "Views: \(model.views)"
    }
    
    func setupView(){
        contentView.addSubview(titlePostLabel)
        //contentView.addSubview(authorPostLabel)
        contentView.addSubview(descriptionPostLabel)
        contentView.addSubview(imagePostView)
        contentView.addSubview(likePostLabel)
        contentView.addSubview(viewPostLabel)
        
        NSLayoutConstraint.activate([
            titlePostLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titlePostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            imagePostView.topAnchor.constraint(equalTo: titlePostLabel.bottomAnchor, constant: 8),
            imagePostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagePostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagePostView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imagePostView.heightAnchor.constraint(equalTo: imagePostView.widthAnchor, multiplier: 1.0),
            
            descriptionPostLabel.topAnchor.constraint(greaterThanOrEqualTo: imagePostView.bottomAnchor, constant: 8),
            descriptionPostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionPostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionPostLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26),
            
            likePostLabel.topAnchor.constraint(greaterThanOrEqualTo: descriptionPostLabel.bottomAnchor, constant: -8),
            likePostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likePostLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            viewPostLabel.topAnchor.constraint(greaterThanOrEqualTo: descriptionPostLabel.bottomAnchor, constant: -8),
            viewPostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewPostLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

