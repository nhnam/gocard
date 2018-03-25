//
//  OptionViewController+Ext.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/26/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

extension OptionViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        else if section == 1 { return 1 }
        else if section == 2 { return 4 }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0.1 }
        else if section == 1 || section == 2 { return 45.0 }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 85.0 }
        else if indexPath.section == 1 { return hasCard ? 186.0 : 85.0 }
        else if indexPath.section == 2 { return 45.0 }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "upload_cell", for: indexPath) as! UploadCell
            cell.viewcontroller = self
            return cell
        } else if indexPath.section == 1 {
            if hasCard {
                let cell = tableView.dequeueReusableCell(withIdentifier: "lockcard_cell", for: indexPath) as! LockCardCell
                cell.viewcontroller = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "empty_cell", for: indexPath) as! EmptyCell
                return cell
            }
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "normal_cell", for: indexPath) as! NormalCell
            cell.viewcontroller = self
            switch indexPath.row {
            case 0: cell.config(title: "About", icon: UIImage(asset:.aboutIcon)); break
            case 1: cell.config(title: "Contact Customer Services", icon: UIImage(asset:.contactIcon)); break
            case 2: cell.config(title: "Your profile", icon: UIImage(asset:.chatIcon)); break
            case 3: cell.config(title: "Send Feedback", icon: UIImage(asset:.feedbackIcon)); break
            default: break
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 && indexPath.section == 2 {
            self.performSegue(withIdentifier: "toAccountSetting", sender: self)
        }
    }
}
