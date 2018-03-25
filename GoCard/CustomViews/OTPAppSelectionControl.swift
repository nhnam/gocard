//
//  OTPAppSelectionControl.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/16/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class OTPAppSelectionControl: UIControl {
    override var isSelected: Bool{
        didSet{
            if isSelected {
                self.backgroundColor = UIColor.blueDeep
            }else{
                self.backgroundColor = UIColor.white
            }
        }
    }
}

class WalletSelectionControl: UIControl {
    override var isSelected: Bool{
        didSet{
            if isSelected {
                self.backgroundColor = UIColor(hex:0xC3C2C2).withAlphaComponent(0.5)
            }else{
                self.backgroundColor = UIColor.white
            }
        }
    }
}
