//
//  GoalCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/13/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import Kingfisher

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalImageView: UIImageView!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var progressBar: ProcessBar!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var currentSavingLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.round(5.0)
        goalImageView.round(5.0)
        currentSavingLabel.characterSpacing(0.55, lineHeight: 13, withFont: UIFont.roboto(size: 11))
        costLabel.characterSpacing(0.55, lineHeight: 13, withFont: UIFont.roboto(size: 11))
        goalNameLabel.characterSpacing(0.75, lineHeight: 18, withFont: UIFont.boldRoboto(size: 15))
        backgroundColor = .clear
    }
    
    func prepareForWillDisplay() {
        progressBar.percent = CGFloat(arc4random()%10)*0.1
        containerView.round(5.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func config(_ goal:Goal) {
        if let url = URL(string:goal.featurePhotoUrl) {
            goalImageView.kf.setImage(with: url)
        }
        goalNameLabel.text = goal.title
    }
    
}
