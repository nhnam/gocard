//
//  Wallet.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 4/2/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import Foundation
import RealmSwift

final class Wallet: Object {
    @objc dynamic var icon = ""
    @objc dynamic var amount:Float = 0.00
    @objc dynamic var unit = ""
    @objc dynamic var name = ""
    override class func primaryKey() -> String? {
        return Key.Wallet.unit.rawValue
    }
    class func generateDemoData() {
        let realm = try! Realm()
        realm.save { [unowned realm] in
            realm.create(Wallet.self, value: ["icon":"US","amount":10000, "unit":"USD", "name":"United States Dollar"], update: true)
            realm.create(Wallet.self, value: ["icon":"sg","amount":10000, "unit":"SGD", "name":"Singapore Dollar"], update: true)
            realm.create(Wallet.self, value: ["icon":"th","amount":10000, "unit":"THB", "name":"Thai Bath"], update: true)
            realm.create(Wallet.self, value: ["icon":"jp","amount":10000, "unit":"JPY", "name":"Japanese Yen"], update: true)
        }
    }
}
