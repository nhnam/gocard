//
//  Transaction.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/24/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import RealmSwift

enum TransactionState {
    case completed
    case waiting
}
enum TransactionType {
    case paying
    case receiving
}

final class Transaction: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var time: Date = Date()
    @objc dynamic var photo: String = ""
    @objc dynamic var amount: String = "00.00"
    @objc dynamic var group: String = "00.00"
    @objc dynamic var isIncome = false
    override class func primaryKey() -> String? {
        return Key.Transaction.id.rawValue
    }
    
    class func generateDemoData() {
        let realm = try! Realm()
        realm.save { [unowned realm] in
            realm.create(Transaction.self, value: ["id":1, "title":" Startbucks", "detail":"Product Payment", "time":Date(), "photo":"Starbucks Icon", "amount":"-  $30.83","group":"Mar 4, 2017"], update: true)
            realm.create(Transaction.self, value: ["id":2, "title":"Anne Miller", "detail":"Sent Payment", "time":Date(), "photo":"Anne Milner", "amount":"-  $20.55","group":"Mar 2, 2017"], update: true)
            realm.create(Transaction.self, value: ["id":3, "title":"Amazon Escrow Inc.", "detail":"Approved Payment", "time":Date(), "photo":"Amazone Icon", "amount":"+  $30.83","group":"Mar 1, 2017","isIncome":true], update: true)
            realm.create(Transaction.self, value: ["id":4, "title":"Anthony Nainggolan", "detail":"Transfer from Bank", "time":Date(), "photo":"Anthony Nainggolan", "amount":"+  $60.00","group":"Mar 1, 2017","isIncome":true], update: true)
            realm.create(Transaction.self, value: ["id":5, "title":"Disneyland Hongkong", "detail":"Product Payment - Completed", "time":Date(), "photo":"Disneyland Hongkong", "amount":"-  $20.55","group":"Mar 1, 2017"], update: true)
        }
    }
}
