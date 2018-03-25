//
//  User.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/23/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import Foundation
import RealmSwift

final class User: Object {
    dynamic var username = ""
    dynamic var lastAccess = Date()
    dynamic var avatarUrl = ""
    dynamic var baseCurrency = ""
    override class func primaryKey() -> String? {
        return Key.User.username.rawValue
    }
}
