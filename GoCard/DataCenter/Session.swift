//
//  Session.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/29/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class Session {
    static var currency:String  = "SGD" {
        didSet{
            DataCenter.refreshEx(onCompleted: { (unitRates:[DataCenter.Rate]) in
            })
        }
    }
    
    static var amount:CGFloat = 120.0
    
    class func logout() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"appDidLogout"), object: nil)
    }
    
    static var editingGoal: Goal?
}
