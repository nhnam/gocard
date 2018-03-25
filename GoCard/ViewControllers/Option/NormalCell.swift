//
//  NormalCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/26/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class NormalCell: UITableViewCell {
    
    @IBOutlet weak var iconView:UIImageView!
    @IBOutlet weak var titleView:UILabel!
    @IBOutlet weak var viewcontroller:UIViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(title plainTitle: String, icon image:UIImage?) {
        titleView.text = plainTitle
        iconView.image = image
        titleView.characterSpacing(0.93, lineHeight: 20, withFont: titleView.font)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
