//
//  ThreeColCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/20/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class ThreeColCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        balanceLabel.characterSpacing(1.15, lineHeight: 11, withFont: UIFont.mediumRoboto(size: 10))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(leftIcon image:UIImage?, centerText center:String, rightText right: String) {
        icon.image = image
        valueLabel.text = center
        unitLabel.text = right
        valueLabel.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.roboto(size: 13))
        unitLabel.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.roboto(size: 13))
    }
}
