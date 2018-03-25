//
//  OptionViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class OptionViewController: BaseViewController {
    
    @IBOutlet weak var optionTable:UITableView!
    
    internal var hasCard:Bool = true {
        didSet{
            optionTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.title = "ACCOUNT SETTING"
    }
    
    @IBAction func didTouchLogout(_ sender: Any) {
        self.showWaiting()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.hideWaiting()
            Session.logout()
        }
    }
}


extension OptionViewController {
    func removeCardCell() {
        hasCard = false
    }
}
