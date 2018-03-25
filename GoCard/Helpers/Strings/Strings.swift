//
//  Strings.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

extension NSMutableAttributedString{
    func setLetterSpace(_ space:CGFloat){
        //if(self.length == 0) {
        //    return
        //}
        self.addAttribute(NSAttributedStringKey.kern, value: space, range: NSRange(location: 0, length: self.length))
    }
    func setLineSpace(_ space:CGFloat){
        //if(self.length == 0) {
        //   return
        //}
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = space
        paragraphStyle.maximumLineHeight = space
        paragraphStyle.lineHeightMultiple = space
        self.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.length))
    }
    convenience init(text:String, space:CGFloat) {
        self.init(string: text, attributes: nil)
        self.setLetterSpace(space)
    }
}

extension String {
    func trim() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func apply(_ attributes:[NSAttributedStringKey : Any]?) -> NSMutableAttributedString {
        let muAttText = NSMutableAttributedString(string: self, attributes: attributes);
        return muAttText
    }
}
