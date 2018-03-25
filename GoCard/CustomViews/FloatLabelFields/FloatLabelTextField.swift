//
//  FloatLabelTextField.swift
//  FloatLabelFields
//
//  Created by Fahim Farook on 28/11/14.
//  Copyright (c) 2014 RookSoft Ltd. All rights reserved.
//
//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//
//  Objective-C version by Jared Verdi
//  https://github.com/jverdi/JVFloatLabeledTextField
//

import UIKit

@IBDesignable final class FloatLabelTextField: UITextField {
	let animationDuration = 0.3
	var title = UILabel()
	var lineColor = UIColor.borderColor
    
	override var accessibilityLabel:String? {
		get {
			if let txt = text , txt.isEmpty { return title.text }
            else { return text }
		}
		set { self.accessibilityLabel = newValue }
	}
	
	@IBInspectable override var placeholder:String? {
		didSet {
            title.text = placeholder
			title.sizeToFit()
            self.setNeedsDisplay()
		}
	}
   
	
	@IBInspectable override var attributedPlaceholder:NSAttributedString? {
		didSet {
			title.attributedText = attributedPlaceholder
			title.sizeToFit()
            self.setNeedsDisplay()
		}
	}
	
	@IBInspectable var titleFont:UIFont = UIFont.systemFont(ofSize: 12.0) {
		didSet {
			title.font = titleFont
			title.sizeToFit()
            self.setNeedsDisplay()
		}
	}
	
	var hintYPadding:CGFloat = 0.0

	@IBInspectable var titleYPadding:CGFloat = 0.0 {
		didSet {
			var r = title.frame
			r.origin.y = titleYPadding
			title.frame = r
            self.setNeedsDisplay()
		}
	}
	
	@IBInspectable var titleTextColour:UIColor = UIColor.gray {
		didSet {
			if !isFirstResponder {
				title.textColor = titleTextColour
                self.setNeedsDisplay()
			}
		}
	}
	
	@IBInspectable var titleActiveTextColour:UIColor! {
		didSet {
			if isFirstResponder {
				title.textColor = titleActiveTextColour
                self.setNeedsDisplay()
			}
		}
	}
    
    @IBInspectable var alwayShowTitle: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
		
	// MARK:- Init
	required init?(coder aDecoder:NSCoder) {
		super.init(coder:aDecoder)
		setup()
	}
	
	override init(frame:CGRect) {
		super.init(frame:frame)
		setup()
	}
    
    private func setCursorPosition(input: UITextField, position: Int) {
        let position = input.position(from: input.beginningOfDocument, offset: position)!
        input.selectedTextRange = input.textRange(from: position, to: position)
    }
	
	// MARK:- Overrides
	override func layoutSubviews() {
		super.layoutSubviews()
		self.setTitlePositionForTextAlignment()
		let isResp = isFirstResponder
		if let txt = text , !txt.isEmpty && isResp { title.textColor = titleActiveTextColour }
        else { title.textColor = titleTextColour }
        if !alwayShowTitle {
            if let txt = text , txt.isEmpty { hideTitle(isResp) }
            else { showTitle(isResp) }
        } else { showTitle(false) }
	}
	
	override func textRect(forBounds bounds:CGRect) -> CGRect {
		var rect = super.textRect(forBounds: bounds)
		if let txt = text , !txt.isEmpty {
			var top = ceil(title.font.lineHeight + hintYPadding)
			top = min(top, maxTopInset())
			rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(top, 0.0, 0.0, 0.0))
		}
		return rect.integral
	}
	
	override func editingRect(forBounds bounds:CGRect) -> CGRect {
		var rect = super.editingRect(forBounds: bounds)
		if let txt = text , !txt.isEmpty {
			var top = ceil(title.font.lineHeight + hintYPadding)
			top = min(top, maxTopInset())
			rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(top, 0.0, 0.0, 0.0))
		}
		return rect.integral
	}
	
	override func clearButtonRect(forBounds bounds:CGRect) -> CGRect {
		var rect = super.clearButtonRect(forBounds: bounds)
		if let txt = text , !txt.isEmpty {
			var top = ceil(title.font.lineHeight + hintYPadding)
			top = min(top, maxTopInset())
			rect = CGRect(x:rect.origin.x, y:rect.origin.y + (top * 0.5), width:rect.size.width, height:rect.size.height)
		}
		return rect.integral
	}
	
	// MARK:- Private Methods
	fileprivate func setup() {
		borderStyle = UITextBorderStyle.none
		titleActiveTextColour = tintColor
		title.alpha = 0.0
		title.font = titleFont
		title.textColor = titleTextColour
		if let str = placeholder , !str.isEmpty {
			title.text = str
			title.sizeToFit()
		}
		self.addSubview(title)
	}

	fileprivate func maxTopInset()->CGFloat {
		if let fnt = font {
			return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
		}
		return 0
	}
	
	fileprivate func setTitlePositionForTextAlignment() {
		let r = textRect(forBounds: bounds)
		var x = r.origin.x
		if textAlignment == .center {
			x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
		} else if textAlignment == .right {
			x = r.origin.x + r.size.width - title.frame.size.width
		}
		title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
	}
	
	fileprivate func showTitle(_ animated:Bool) {
		let dur = animated ? animationDuration : 0
		UIView.animate(withDuration: dur, delay:0, options: [.beginFromCurrentState, .curveEaseOut], animations:{ [unowned self] in
            self.title.alpha = 1.0
            var titleFrame = self.title.frame
            titleFrame.origin.y = self.titleYPadding
            self.title.frame = titleFrame
            self.title.sizeToFit()
        }, completion:nil)
	}
	
	fileprivate func hideTitle(_ animated:Bool) {
		let dur = animated ? animationDuration : 0
		UIView.animate(withDuration: dur, delay:0, options: [.beginFromCurrentState, .curveEaseIn], animations:{ [unowned self] in
			self.title.alpha = 0.0
			var titleFrame = self.title.frame
			titleFrame.origin.y = self.title.font.lineHeight + self.hintYPadding
			self.title.frame = titleFrame
            self.title.sizeToFit()
        }, completion:nil)
	}
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let lineColor = self.lineColor
        lineColor.setStroke()
        let path = UIBezierPath()
        path.lineWidth = UIScreen.main.scale > 1 ? 2 : 2
        let leftPoint = CGPoint(x:0, y:rect.height)
        let rightPoint = CGPoint(x:rect.width, y:rect.height)
        path.move(to: leftPoint)
        path.addLine(to: rightPoint)
        path.stroke()
    }
    
    override func drawPlaceholder(in rect: CGRect) {
        var selfRect = self.bounds
        var top = ceil(title.font.lineHeight + hintYPadding)
        top = min(top, maxTopInset())
        selfRect = UIEdgeInsetsInsetRect(selfRect, UIEdgeInsetsMake(top, 0.0, 0.0, 0.0))
        super.drawPlaceholder(in: selfRect)
    }
}
