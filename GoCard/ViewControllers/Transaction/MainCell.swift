//
//  MainCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/23/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class MainCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subLabel: UILabel?
    @IBOutlet weak var rightLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style(isIncome: false)
    }
    
    func style(isIncome:Bool) {
        _ = titleLabel?.characterSpacing(0.09, lineHeight: 16, withFont: UIFont(name: "Helvetica Neue", size: 13) ?? UIFont.sfUIText(size: 13))
        _ = subLabel?.characterSpacing(0.27, lineHeight: 12, withFont: UIFont(name: "Helvetica Neue", size: 11) ?? UIFont.sfUIText(size: 11))
        guard let atts = rightLabel?.characterSpacing(0.22, lineHeight: 16, withFont: UIFont.sfUIText(size: 14)) else { return }
        atts.addAttribute(NSAttributedStringKey.foregroundColor, value: (isIncome ? UIColor(hex:0x009977) : UIColor.textDefault), range: NSRange(location: 0, length: atts.length))
        rightLabel?.attributedText = atts
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
