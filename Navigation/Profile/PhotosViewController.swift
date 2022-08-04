//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.08.2022.
//

import UIKit

class PhotosViewController: UIViewController {


    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Default")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "Custom")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var dataSourse: [String] = []
    private func createData(){
        for num in 1...Constants.numberOfItemsInSection {
            dataSourse.append("\(num).jpg")
        }}

    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        setupNavigationBar()
        setupView()

    }

    private func setupNavigationBar(){
        //navigationController?.navigationBar.isHidden = false
        navigationItem.title = Constants.collectionPhotoTitle

    }
// когда уходим с вью коллекции, скрываем навигатор-бар
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
// когда приходим на вью коллекции, показываем навигатор-бар
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    private func setupView(){
        view.addSubview(collectionView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourse.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as? PhotosCollectionViewCell {
            cell.setupCell(for: dataSourse[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let width = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = floor(width / Constants.numberOfItemsInLine)

        return CGSize(width: itemWidth, height: itemWidth)
    }



}
