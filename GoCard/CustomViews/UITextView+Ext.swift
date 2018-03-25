//
//  UITextView+Ext.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/19/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

private var spaceLetters: CGFloat = 1.0

extension UITextView {
    var letterSpace:CGFloat! {
        get {
            return objc_getAssociatedObject(self, &spaceLetters) as? CGFloat
        }
        set(newValue) {
            objc_setAssociatedObject(self, &spaceLetters, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            self.characterSpacing(spaceLetters)
        }
    }
    
    func characterSpacing(_ space:CGFloat, lineHeight height:CGFloat = 18, withFont font:UIFont = UIFont.roboto(size: 14)){
        guard let text = self.text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.setLetterSpace(space)
        attributedString.setLineSpace(height)
        attributedString.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}

