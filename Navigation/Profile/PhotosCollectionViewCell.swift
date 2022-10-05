//
//  CustomUICollectionViewCell.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.08.2022.
//

import UIKit

// отдельный экран, где фотографии
class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageCollectionView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(imageCollectionView)
        
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: topAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func setImage(image: UIImage) {
        imageCollectionView.image = image
    }
    
//    func setupCell(for imageName:String, or indexPath: IndexPath, arrayOfImages: [String]) {
//        let arrayOfFinishedImages: [UIImage] = PhotoEdditer().createArrayOfImages(arrayOf: arrayOfImages)
//        imageCollectionView.image = arrayOfFinishedImages[indexPath.row]
//    }
    
//    func setupCell(for imageName:String){
//        self.imageCollectionView.image = UIImage(named: imageName)
//    }
    
    func setupCell(for imageName: UIImage){
        self.imageCollectionView.image = imageName
    }
    
}
