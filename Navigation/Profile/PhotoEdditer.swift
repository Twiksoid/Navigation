//
//  PhotoEdditer.swift
//  Navigation
//
//  Created by Nikita Byzov on 27.09.2022.
//

import UIKit
import iOSIntPackage

final class PhotoEdditer {

    private let imageProcessor = ImageProcessor()
     var finalImagesArray: [UIImage] = []

    func createArrayOfImages(arrayOf: [String]) -> [UIImage] {
        for i in 1...Constants.numberOfItemsInSection {
            var finishedImage = UIImage()
            // тут обрабатываем имя фото, возввращаем его в массив. Итого в массиве будет 4 обработанных фото
            imageProcessor.processImage(sourceImage: UIImage(named: arrayOf[i])!, filter: .colorInvert) { finishedImage = $0 ?? UIImage(named: "1.jpg" )! }
            finalImagesArray.append(finishedImage)
        }
         return finalImagesArray
    }

}
