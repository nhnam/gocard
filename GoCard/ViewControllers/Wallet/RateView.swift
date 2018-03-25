//
//  RateView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/20/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class RateView: UIView , UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var titles: [UILabel]!
    private let ratingData = [["icon":#imageLiteral(resourceName: "US"),"buy":"34.30","sell":"34.80"],
                              ["icon":#imageLiteral(resourceName: "CN"),"buy":"36.71","sell":"36.90"],
                              ["icon":#imageLiteral(resourceName: "EU"),"buy":"43.05","sell":"44.05"],
                              ["icon":#imageLiteral(resourceName: "HK"),"buy":"34.45","sell":"34.70"]]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        tableView.register(UINib(nibName: "ThreeColCell", bundle: nil), forCellReuseIdentifier: "rate_cell")
        titles.forEach {
            $0.characterSpacing(1.15, lineHeight: 11, withFont: UIFont.mediumRoboto(size: 10))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rate_cell", for: indexPath) as! ThreeColCell
        let data = ratingData[indexPath.row]
        cell.config(leftIcon: data["icon"] as! UIImage, centerText: data["buy"] as! String, rightText: data["sell"] as! String)
        return cell
    }
}
