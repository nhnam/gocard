//
//  Colors.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/10/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    // gradient start
    open class var blueLight:UIColor {
        return UIColor(hex:0x81D7FB)
    }
    // gradient end
    open class var blueDeep:UIColor {
        return UIColor(hex:0x269EFD)
    }
    open class var tabBarTint:UIColor{
        return UIColor(hex:0x5DC0FB)
    }
    open class var tabBarUnselectedTint:UIColor{
        return UIColor(hex:0xCCCCCC)
    }
    open class var borderColor:UIColor {
        return UIColor(hex:0xCCCCCC)
    }
    open class var scrollBackground:UIColor{
        return UIColor(hex:0xF6F9FF)
    }
    open class var blueButton:UIColor{
        return UIColor(hex:0x4BB5FC)
    }
    open class var greenButton:UIColor{
        return UIColor(hex:0x71E373)
    }
    open class var blueDropdownButton:UIColor{
        return UIColor(hex:0xAADFFC)
    }
    open class var grayText:UIColor{
        return UIColor(hex:0x777777)
    }
    open class var textDefault:UIColor{
        return UIColor(hex:0x333333)
    }
}
