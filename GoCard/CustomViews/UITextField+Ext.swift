//
//  UITextField+Ext.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/18/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

private var letterSpace: CGFloat = 1.0

extension UITextField {
    var space:CGFloat! {
        get {
            return objc_getAssociatedObject(self, &letterSpace) as? CGFloat
        }
        set(newValue) {
            objc_setAssociatedObject(self, &letterSpace, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            self.characterSpacing(letterSpace)
        }
    }
    func characterSpacing(_ space:CGFloat){
        //guard let text = self.text else {
        //    return
        //}
        let text = self.text ?? ""
        let attributedString = NSMutableAttributedString(string: text)
        if let font = self.font {
            attributedString.addAttributes([NSFontAttributeName: font], range: NSRange(location:0, length: attributedString.length))
        }
        attributedString.setLetterSpace(space)
        self.attributedText = attributedString
    }
    
    func addImageLeftView( _ image: UIImage) {
        let leftView = UIImageView(image: image)
        leftView.contentMode = .center
        leftView.frame = CGRect(x: 0, y: 0, width: Int(self.frame.size.height), height: Int(self.frame.size.height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
}

