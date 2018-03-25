//
//  RoundedView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/13/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
    }
    
}
