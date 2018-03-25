//
//  Slider.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/10/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import Darwin

protocol SliderListener{
    func slider(slider:Slider, didUpdate newValue:CGFloat)
}

class Slider:UIControl {
    open var currentValue:Int {
        get {
            return Int(ceilf(Float(self.xThumb*10)/Float(self.bounds.size.width)))
        }
    }
    private var xThumb: CGFloat = 0.0
    private var thumbSize: CGFloat = 0.0
    open var listener:SliderListener?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xThumb = self.bounds.size.width/2
        thumbSize = self.bounds.size.height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        xThumb = self.bounds.size.width/2
        thumbSize = self.bounds.size.height
    }

    override func draw(_ rect: CGRect) {
        //super.draw(rect)
        let barH = thumbSize/2
        let bgPath = UIBezierPath(roundedRect: CGRect(x:0, y:(thumbSize - barH)/2, width:self.bounds.size.width, height:barH), cornerRadius: barH/2)
        let bgColor = UIColor.lightGray
        bgColor.set()
        bgPath.fill()
        let thumbPath = UIBezierPath(ovalIn: CGRect(x:xThumb, y:0, width:thumbSize, height:thumbSize))
        let thumbColor = UIColor.blueDeep
        thumbColor.set()
        thumbPath.fill()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        return true
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let lastPoint = touch.location(in: self)
        if(lastPoint.x >= thumbSize/2 && lastPoint.x <= self.frame.size.width - thumbSize/2) {
            self.moveHandle(lastPoint)
            self.sendActions(for: .valueChanged)
        }
        return super.continueTracking(touch, with: event)
    }
    func moveHandle(_ lastPoint:CGPoint){
        xThumb = lastPoint.x - thumbSize/2
        self.setNeedsDisplay()
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        let value:CGFloat = CGFloat(self.currentValue)*0.1
        listener?.slider(slider: self, didUpdate: value)
    }
}
