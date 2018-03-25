//
//  SendMethodCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/15/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class SendMethodCell: UIControl {
    @IBOutlet weak var iconButton:UIButton!
    @IBOutlet weak var name:UILabel!
    override var isSelected: Bool{
        didSet{
            if isSelected {
                self.backgroundColor = UIColor.blueDeep
            }else{
                self.backgroundColor = UIColor.white
            }
            iconButton.isSelected = isSelected
            name.textColor = isSelected ? UIColor.white : UIColor.textDefault
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.characterSpacing(0.5, lineHeight: 11, withFont: UIFont.boldRoboto(size:8))
    }
}
