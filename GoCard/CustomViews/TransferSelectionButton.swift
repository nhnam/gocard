//
//  TransferSelectionButton.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/23/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class TransferSelectionButton: UIButton {
    private var selectedLineView:UIView?
    override var isSelected: Bool{
        didSet{
            if isSelected {
                UIView.animate(withDuration: 0.25, animations: {
                    self.selectedLineView?.backgroundColor = .white
                })
            }else{
                UIView.animate(withDuration: 0.25, animations: {
                    self.selectedLineView?.backgroundColor = .clear
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .white
        self.adjustsImageWhenHighlighted = false
        let size = self.titleLabel?.textRect(forBounds: self.bounds, limitedToNumberOfLines: 1)
        let lineWidth = (size?.width ?? self.bounds.size.width) - 5
        selectedLineView = UIView(frame: CGRect(x: (self.bounds.size.width - lineWidth)/2.0, y: self.bounds.size.height - 3, width: lineWidth, height: 3))
        selectedLineView!.round()
        self.addSubview(selectedLineView!)
    }
}
