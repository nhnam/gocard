//
//  EmptyCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 4/1/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class EmptyCell: UITableViewCell {

    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyBackgroundView: UIView!
    private var border = CAShapeLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        border.strokeColor = UIColor.borderColor.cgColor
        border.fillColor = nil
        border.lineDashPattern = [4,2]
        emptyBackgroundView.layer.addSublayer(border)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        border.path = UIBezierPath(rect: emptyBackgroundView.bounds).cgPath
        border.frame = emptyBackgroundView.bounds
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
