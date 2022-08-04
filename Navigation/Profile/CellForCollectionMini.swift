//
//  CellForCollectionMini.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.08.2022.
//

import UIKit

// ячейка, которая будет использоваться для вывода данных в мини коллекцию

class CellForCollectionMini: UICollectionViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var arrowLabel: UILabel = {
        let label = UILabel()
        label.text = "arrow"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageCollection: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(arrowLabel)
        addSubview(imageCollection)

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: imageCollection.topAnchor, constant: -12),

            arrowLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            arrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            imageCollection.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 32)/4),
            imageCollection.heightAnchor.constraint(equalTo: imageCollection.widthAnchor, multiplier: 1),
            imageCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 12)

        ])
    }

    func setImage(for image: String){
        imageCollection.image = UIImage(named: image)
    }
}
