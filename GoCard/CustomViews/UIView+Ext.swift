//
//  UIView+Ext.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/9/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import ObjectiveC
import Dispatch

private var GLOWVIEW_KEY = "GLOWVIEW"

extension UIView {
    
    @objc func glowWithColor(color:UIColor) {
        var image:UIImage
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale); do {
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            color.setFill()
            path.fill(with: .sourceAtop, alpha:1.0)
            image = UIGraphicsGetImageFromCurrentImageContext()!
        }
        UIGraphicsEndImageContext()
        let glowView = UIImageView(image: image)
        self.layer.insertSublayer(glowView.layer, below: self.layer)
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1.0
    }
    
    @objc func round(){
        self.layer.cornerRadius = self.bounds.size.height/2
    }
    @objc func round(_ radius:CGFloat){
        self.layer.cornerRadius = radius
    }
    @objc func roundBorder(_ radius: CGFloat, borderWidth width: CGFloat = 1, borderColor color:UIColor = UIColor(hex:0xCCCCCC)){
        self.round(radius)
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    @objc func roundBorder(_ width: CGFloat = 1, borderColor color:UIColor = UIColor(hex:0xCCCCCC)){
        self.round()
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    @objc func decorate(_ width: CGFloat = 1, borderColor color:UIColor = UIColor(hex:0xCCCCCC)){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func rotate(in duration: Double) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = -(Double.pi * 2.0)
        animation.duration = 1.0
        animation.isCumulative = true
        animation.repeatCount = .infinity
        self.layer.add(animation, forKey: "rotationAnimation")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            self.layer.removeAllAnimations()
        }
    }
}


extension CALayer {
    func glowWithColor(color:UIColor) {
        var image:UIImage
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale); do {
            self.render(in: UIGraphicsGetCurrentContext()!)
            let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            color.setFill()
            path.fill(with: .sourceAtop, alpha:1.0)
            image = UIGraphicsGetImageFromCurrentImageContext()!
        }
        UIGraphicsEndImageContext()
        let glowView = UIImageView(image: image)
        self.insertSublayer(glowView.layer, below: self)
        self.shadowColor = color.cgColor
        self.shadowOffset = CGSize.zero
        self.shadowRadius = 5
        self.shadowOpacity = 1.0
    }
    
    func round(){
        self.cornerRadius = self.bounds.size.height/2
    }
}

extension UIView {
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _round(corners: corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
    
}

private extension UIView {
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    
}

extension UIButton {
    override func glowWithColor(color: UIColor) {
        var image:UIImage
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale); do {
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            color.setFill()
            path.fill(with: .sourceAtop, alpha:1.0)
            image = UIGraphicsGetImageFromCurrentImageContext()!
        }
        UIGraphicsEndImageContext()
        let glowView = UIImageView(image: image)
        self.layer.insertSublayer(glowView.layer, at: 0)
        
        self.layer.backgroundColor = color.cgColor
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1.0
    }
    
    func characterSpacing(_ space:CGFloat, lineHeight height: CGFloat = 18.0, withFont font: UIFont = UIFont.roboto(size: 14)){
        guard let text = self.title(for: .normal) else {
            return
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.setLetterSpace(space)
        attributedString.setLineSpace(height)
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        if let color = self.titleLabel?.textColor {
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSRange(location: 0, length: attributedString.length))
        }
        self.setAttributedTitle(attributedString, for: .normal)
        self.setAttributedTitle(attributedString, for: .selected)
    }
    
    func centerButtonAndImageWithSpacing(_ spacing:CGFloat){
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
    }
    
    func peek(done:(()->())? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { (finish) in
                done?()
            })
        })
    }
}

private var letterSpace: CGFloat = 2.0
extension UILabel {
    var space:CGFloat! {
        get {
            return objc_getAssociatedObject(self, &letterSpace) as? CGFloat
        }
        set(newValue) {
            objc_setAssociatedObject(self, &letterSpace, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            _ = self.characterSpacing(letterSpace)
        }
    }
    
    @discardableResult func characterSpacing(_ space:CGFloat, lineHeight height: CGFloat = 18.0, withFont font: UIFont = UIFont.roboto(size: 14)) -> NSMutableAttributedString {
        guard let text = self.text else {
            return NSMutableAttributedString()
        }
        let textAlignment = self.textAlignment
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.setLetterSpace(space)
        attributedString.setLineSpace(height)
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
        self.textAlignment = textAlignment
        
        return attributedString
    }
    override func round() {
        self.layer.masksToBounds = true
        super.round()
    }
}
