//
//  Font.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

extension UIFont {
    open class var SourceSansProReg:String {
        return "SourceSansPro-Regular"
    }
    open class var SourceSansProBold:String {
        return "SourceSansPro-Bold"
    }
    open class var Roboto:String {
        return "Roboto-Regular"
    }
    open class var RobotoBold:String {
        return "Roboto-Bold"
    }
    open class var RobotoMedium:String {
        return "Roboto-Medium"
    }
    open class var OpenSansBold:String {
        return "OpenSans-Bold"
    }
    open class var OpenSans:String {
        return "OpenSans"
    }
    open class var SFUIText:String {
        return "SFUIText-Regular"
    }
    open class var RobotoCondensed:String {
        return "Roboto-Condensed"
    }
    open class var textFieldTitle:UIFont {
        return UIFont(name: RobotoBold, size: 12)!
    }
    open class var navigationBarTitle:UIFont {
        return UIFont(name: SourceSansProBold, size: 14)!
    }
    class func listAllFont(){
        _ = UIFont.familyNames.map {
            let fontNames = UIFont.fontNames(forFamilyName: $0)
            print("Font Family: \($0), Font Names: \(fontNames)\n")
        }
    }
    open class func roboto(size fontSize:CGFloat) -> UIFont {
        return UIFont(name: Roboto, size: fontSize)!
    }
    open class func boldRoboto(size fontSize:CGFloat) -> UIFont {
        return UIFont(name: RobotoBold, size: fontSize)!
    }
    open class func mediumRoboto(size fontSize:CGFloat) -> UIFont {
        return UIFont(name: RobotoMedium, size: fontSize)!
    }
    open class func openSans(size fontSize:CGFloat) -> UIFont {
        return UIFont(name: OpenSans, size: fontSize)!
    }
    open class func boldOpenSans(size fontSize:CGFloat) -> UIFont {
        return UIFont(name: OpenSansBold, size: fontSize)!
    }
    open class func sfUIText(size fontSize:CGFloat) -> UIFont {
        return UIFont(name: SFUIText, size: fontSize)!
    }
    open class func robotoCondensed(size fontSize:CGFloat) -> UIFont {
        return UIFont(name: RobotoCondensed, size: fontSize)!
    }
}
