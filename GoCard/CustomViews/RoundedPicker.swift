//
//  RoundedPicker.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/25/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class RoundedPicker: UIControl {
    @IBOutlet var rightIconView:UIImageView?
    @IBOutlet var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        round()
        backgroundColor = UIColor(hex:0xAADFFC)
        rightIconView?.image = UIImage(asset: .dropIconWhite)
        guard let attributes = titleLabel?.characterSpacing(0.55, lineHeight: 16, withFont: UIFont.roboto(size:14)) else { return }
        attributes.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex:0xFCFCFD), range: NSRange(location:0, length: attributes.length))
        titleLabel?.attributedText = attributes
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
