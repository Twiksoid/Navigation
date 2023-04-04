//
//  ModelAuth.swift
//  Navigation
//
//  Created by Nikita Byzov on 15.11.2022.
//

import Foundation
import RealmSwift
import UIKit

class AuthorizationModel: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var login: String?
    @Persisted var password: String?
    @Persisted var isLogin: Bool?
    @Persisted var fullName: String?
    @Persisted var photo: String?
    @Persisted var status: String?
}
