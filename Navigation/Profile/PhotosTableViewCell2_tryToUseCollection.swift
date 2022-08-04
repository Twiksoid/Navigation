//
//  PhotosTableViewCell2.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.08.2022.
//

import UIKit

class PhotosTableViewCell2_tryToUseCollection: UITableViewCell {

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy var miniCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CellForCollectionMini.self, forCellWithReuseIdentifier: "miniCollection")
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    var imagesModel: [String] = ["1.jpg","2.jpg","3.jpg","4.jpg"]


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    private func setupView(){
        addSubview(miniCollection)

        NSLayoutConstraint.activate([
            miniCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            miniCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            miniCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            miniCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PhotosTableViewCell2_tryToUseCollection: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "miniCollection", for: indexPath) as? CellForCollectionMini {
            cell.setImage(for: imagesModel[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
            return cell
        }
    }


}
