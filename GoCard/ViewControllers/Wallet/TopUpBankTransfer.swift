//
//  TopUpBankTransfer.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/21/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class TopUpBankTransfer: UIView {

    @IBOutlet var textfields: [UITextField]!
    @IBOutlet var titles: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textfields.forEach {
            $0.characterSpacing(1.14)
        }
        titles.forEach {
            $0.characterSpacing(1.14, lineHeight: 16, withFont: UIFont.mediumRoboto(size: 14))
        }
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTouchView(_:))))
    }
    
    func didTouchView(_ sender:UIGestureRecognizer?) {
        textfields.forEach { if $0.canResignFirstResponder { $0.resignFirstResponder() } }
    }
}
