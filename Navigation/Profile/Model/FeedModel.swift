//
//  FeedModel.swift
//  Navigation
//
//  Created by Nikita Byzov on 29.09.2022.
//

import UIKit

class FeedModel {
    let secretWord: String = "Hello"
    
    func check(word: String) -> Bool{
        if word == secretWord {
            return true
        } else {
            return false
        }
    }
}
