//
//  TransactionViewController+Ext.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 4/1/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func isSearching() -> Bool {
        return (searchField.text?.characters.count ?? 0) > 1
    }
    internal func resetFilter() {
        mainTable.reloadData()
    }
    
    internal func numOfSectionMainTable() -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == mainTable { return numOfSectionMainTable()
        } else if tableView == timeTable { return 2
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x:0,y:0,width: tableView.frame.size.width, height: 20))
        headerView.backgroundColor = UIColor.white
        if tableView == mainTable {
            let label = UILabel(frame: headerView.bounds)
            var sectionText:String = ""
            if section == 0 {
                sectionText = "Mar 4, 2017"
            }
            else if section == 1 {
                sectionText = "Mar 2, 2017"
            }
            else if section == 2 {
                sectionText = "Mar 1, 2017"
            }
            label.text = sectionText
            label.textColor = UIColor(hex:0x999999)
            _ = label.characterSpacing(0.17, lineHeight: 20, withFont: UIFont.mediumRoboto(size: 11))
            label.textAlignment = .center
            headerView.addSubview(label)
        } else if tableView == timeTable {
            let label = UILabel(frame: headerView.bounds)
            label.text = (section == 0) ? "2017" :"2016"
            label.textColor = UIColor(hex:0x999999)
            _ = label.characterSpacing(0.17, lineHeight: 20, withFont: UIFont.boldRoboto(size: 12))
            label.textAlignment = .center
            headerView.addSubview(label)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainTable {
            if section == 0 { return  !isSearching() ? group1.count : group1Filtered.count}
            else if section == 1 { return !isSearching() ? group2.count : group2Filtered.count }
            else if section == 2 { return !isSearching() ? group3.count : group3Filtered.count }
            else { return 0 }
        } else if tableView == timeTable { return 12
        } else { return 0 }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainTable {
            return mainTableCellForRowAt(indexPath: indexPath)
        } else if tableView == timeTable {
            return timeTableCellForRowAt(indexPath: indexPath)
        } else {
            return UITableViewCell()
        }
    }
    
    private func dataForIndexPath(indexPath: IndexPath) -> Transaction? {
        var transaction: Transaction?
        switch indexPath.section {
        case 0:
            transaction = !isSearching() ? group1[indexPath.row] : group1Filtered[indexPath.row]
            break
        case 1:
            transaction = !isSearching() ? group2[indexPath.row] : group2Filtered[indexPath.row]
            break
        case 2:
            transaction = !isSearching() ? group3[indexPath.row] : group3Filtered[indexPath.row]
            break
        default:
            break
        }
        return transaction
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == mainTable, let aCell = cell as? MainCell, let tran = dataForIndexPath(indexPath: indexPath) {
            aCell.iconView?.image = UIImage(named:tran.photo)
            aCell.titleLabel?.text = tran.title
            aCell.subLabel?.text = tran.detail
            aCell.rightLabel?.text = tran.amount
            aCell.style(isIncome:tran.isIncome)
        }
    }
    
    private func mainTableCellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTable.dequeueReusableCell(withIdentifier: "main_cell", for: indexPath) as! MainCell
        return cell
    }
    private func timeTableCellForRowAt(indexPath: IndexPath) -> UITableViewCell {
        let cell = timeTable.dequeueReusableCell(withIdentifier: "time_cell", for: indexPath)
        if let aCell = cell as? TimeCell {
            aCell.title.text = getMonthFromInt(indexPath.row)
        }
        return cell
    }
    
    static func screenshotOf(_ window: UIWindow) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, true, UIScreen.main.scale)
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        window.layer.render(in: currentContext)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == mainTable {
            tableView.deselectRow(at: indexPath, animated: true)
            if let vc = transactionDetailVC {
                guard let window = UIApplication.shared.keyWindow as UIWindow? else { return }
                vc.backgroundImageView.image = TransactionViewController.screenshotOf(window)
                self.navigationController?.present(vc, animated: true, completion: nil)
            }
        } else {
            print("load data for selected time")
        }
    }
}
