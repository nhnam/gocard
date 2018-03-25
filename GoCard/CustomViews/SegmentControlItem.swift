//
//  SegmentControlItem.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/16/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class SegmentControlItem: UIControl {
    @IBOutlet weak var title:UILabel?
    
    private var selectedLineView:UIView?
    
    @IBInspectable var active:Bool = false {
        didSet{
            self.isSelected = active
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var lineColor: UIColor = UIColor(hex:0x2476B4) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                UIView.animate(withDuration: 0.25, animations: { 
                    self.selectedLineView?.backgroundColor = self.lineColor
                })
                _ = self.title?.characterSpacing(1.27, lineHeight: 13, withFont: UIFont.boldRoboto(size:11))
            }else{
                UIView.animate(withDuration: 0.25, animations: {
                    self.selectedLineView?.backgroundColor = UIColor.clear
                })
                _ = self.title?.characterSpacing(1.27, lineHeight: 13, withFont: UIFont.mediumRoboto(size:11))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedLineView = UIView(frame: CGRect(x: 0, y: self.bounds.size.height - 4, width: self.bounds.size.width, height: 4))
        _ = self.title?.characterSpacing(1.27, lineHeight: 13, withFont: UIFont.mediumRoboto(size:11))
        self.addSubview(selectedLineView!)
    }
}
