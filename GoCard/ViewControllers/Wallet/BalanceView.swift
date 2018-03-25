//
//  BalanceView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/20/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import RealmSwift

struct Balance {
    var icon:Image
    var value:Float
    var unit:String
    var rate:Float
}

class BalanceView: UIView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var titles: [UILabel]!
    internal var notificationToken: NotificationToken?
    
    internal var walletData:[Wallet] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        tableView.register(UINib(nibName: "ThreeColCell", bundle: nil), forCellReuseIdentifier: "balance_cell")
        titles.forEach {
            $0.characterSpacing(1.15, lineHeight: 11, withFont: UIFont.mediumRoboto(size: 10))
        }
        let realm = try! Realm()
        let wallets = realm.objects(Wallet.self).sorted(byKeyPath: "amount", ascending: false)
        notificationToken = wallets.observe { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self.walletData.removeAll()
                self.walletData.append(contentsOf: wallets)
                self.tableView.reloadData()
                break
            case .update(_, _, _, _):
                self.walletData.removeAll()
                self.walletData.append(contentsOf: wallets)
                self.tableView.reloadData()
                break
            case .error(let err):
                fatalError("\(err)")
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "balance_cell", for: indexPath) as! ThreeColCell
        let wallet = walletData[indexPath.row]
        cell.config(leftIcon:UIImage(named:wallet.icon), centerText: wallet.amount.decimalString()!, rightText: wallet.unit)
        return cell
    }
}
