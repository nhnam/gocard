//
//  PinTextfield.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/29/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

@IBDesignable final class PinTextfield: LineTextField {
    @IBOutlet weak var prevField: PinTextfield?
    @IBOutlet weak var nextField: PinTextfield?
    
    func next(){
        if let next = nextField {
                if next.canBecomeFirstResponder { next.becomeFirstResponder() }
        } else {
            if self.canResignFirstResponder { self.resignFirstResponder() }
        }
    }
    func back(){
        if let back = prevField {
            if back.canBecomeFirstResponder { back.becomeFirstResponder() }
        } else {
            if self.canResignFirstResponder { self.resignFirstResponder() }
        }
    }
}
