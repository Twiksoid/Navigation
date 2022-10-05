//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Nikita Byzov on 03.08.2022.
//

import UIKit
import iOSIntPackage

//protocol ImagesDelegate {
//    func setFor(image: UIImage?)
//}

class PhotosViewController: UIViewController {
    
    //private lazy var imagePublisherFacede = ImagePublisherFacade()
    //private lazy var arrayOfImagesForObserver = [UIImage]()
    // lazy var arrayOfImages = [UIImage]()
    
    var arrayOfImages = [UIImage]()
    let imageProcessor = ImageProcessor()
    var arrayOfFinishedImages = [CGImage?]()
    
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
        
        var checkedImages: [CGImage?] = []
        for num in 1...Constants.numberOfItemsInSection {
            dataSourse.append("\(num).jpg")
        }
        
        for image in dataSourse {
            arrayOfImages.append((UIImage(named: image) ?? UIImage(named: "1.jpg"))!)
        }
        
        print("Array of Images: ", "\n", arrayOfImages)
        DispatchQueue.main.async {
            
            let start = DispatchTime.now() // <<<<<<<<<< Start time
            self.imageProcessor.processImagesOnThread(sourceImages: self.arrayOfImages,
                                                      filter: .colorInvert,
                                                      qos: .utility)
            { [weak self] image in self?.arrayOfFinishedImages = image.map( { image in UIImage(cgImage: image!) as! CGImage? } )
                // arrayOfFinishedImages = checkedImages
                let end = DispatchTime.now()   // <<<<<<<<<<   end time
                
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
                //print("Time to evaluate problem: \(timeInterval) seconds")
                
                print("array Of Finished Images: ", "\n", self!.arrayOfFinishedImages)
            }}
        
        //"qos: .userInteractive and filter: .tonal - 5.825e-05 seconds"
        //"qos: .default and filter: .chrome - 7.0084e-05 seconds "
        //"qos: .utility and filter: .colorInvert -  3.075e-05 seconds"
    }
    
    //    private func setupArray() {
    //
    //        dataSourse.forEach { photo in
    //            self.arrayOfImagesForObserver.append(UIImage(named: photo)!)
    //        }
    //        imagePublisherFacede.addImagesWithTimer(time: 1, repeat: 21, userImages: arrayOfImagesForObserver)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createData()
        setupNavigationBar()
        setupView()
        //setupArray()
    }
    
    private func setupNavigationBar(){
        navigationItem.title = Constants.collectionPhotoTitle
        
    }
    // когда уходим с вью коллекции, скрываем навигатор-бар
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        // отписка на наблюдения
        //imagePublisherFacede.removeSubscription(for: self)
    }
    // когда приходим на вью коллекции, показываем навигатор-бар
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        // подписка на наблюдения
        //imagePublisherFacede.subscribe(self)
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
        //arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as? PhotosCollectionViewCell {
            cell.setupCell(for: UIImage(cgImage: arrayOfFinishedImages[indexPath.row]!))
            //cell.setupCell(for: arrayOfImages[indexPath.row])
            //cell.setImage(image: arrayOfImages[indexPath.row])
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

//extension PhotosViewController: ImageLibrarySubscriber {
//    func receive(images: [UIImage]) {
//        arrayOfImages = images
//        collectionView.reloadData()
//    }
//}


