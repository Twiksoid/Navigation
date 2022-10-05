//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.08.2022.
//

import UIKit
import iOSIntPackage


class PhotosViewController: UIViewController {
    
    var arrayOfImages = [UIImage]() // массив имен фото
    var arrayOfFinishedImages = [UIImage?]() // массив обработанных на потоке фото
    
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
        
        // создаем массив фото. Каждое фото в имени цифру имеет, поэтому так можно
        for num in 1...Constants.numberOfItemsInSection {
            dataSourse.append("\(num).jpg")
        }
        
        // перекладываем фото для другого массива, едфолтом положим все картинки 1, если что-то не так пойдет
        for image in dataSourse {
            arrayOfImages.append((UIImage(named: image) ?? UIImage(named: "1.jpg"))!)
        }
        
        let start = DispatchTime.now() // засекаем начало операции
        ImageProcessor().processImagesOnThread(sourceImages: arrayOfImages,
                                               filter: .colorInvert,
                                               qos: .utility)
        { [weak self] checkedImages in DispatchQueue.main.async {
            self?.arrayOfFinishedImages = checkedImages.compactMap { image in
                if let image = image {
                    return UIImage(cgImage: image)
                } else {
                    return nil
                }
            }
            self?.collectionView.reloadData()
        }
        }
        
        let end = DispatchTime.now()   // фиксируем конец
        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Считаем разницу в нано-секундах (UInt64)
        // это если нужно посчитать для других вариантов
        // let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
        //print("Time to evaluate problem: \(timeInterval) seconds")
        
        //MARK: результаты теста
        //"qos: .userInteractive and filter: .tonal - 5.825e-05 seconds"
        //"qos: .default and filter: .chrome - 7.0084e-05 seconds "
        //"qos: .utility and filter: .colorInvert -  3.075e-05 seconds"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        setupNavigationBar()
        setupView()
    }
    
    private func setupNavigationBar(){
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
        arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as? PhotosCollectionViewCell {
            if !arrayOfFinishedImages.isEmpty, let image = arrayOfFinishedImages[indexPath.row] {
                cell.setupCell(for: image)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // чтобы ширина автоматически подбиралась под рамзеры устройства
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let width = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = floor(width / Constants.numberOfItemsInLine)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}


