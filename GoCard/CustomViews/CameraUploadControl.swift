//
//  CameraUploadControl.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/21/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class CameraUploadControl: UIControl {
    @IBOutlet weak var title:UILabel!
    @IBOutlet weak var image:UIImageView!
    override var isSelected: Bool{
        didSet{
            if isSelected {
                self.backgroundColor = UIColor(hex:0xC3C2C2)
            }else{
                self.backgroundColor = UIColor.clear
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        round(10)
        title.characterSpacing(1.14, lineHeight: 21, withFont: UIFont.mediumRoboto(size:18))
    }
}
