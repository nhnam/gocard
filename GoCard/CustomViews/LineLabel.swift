//
//  LineLabel.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/10/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class LineLabel: UILabel {
    let lineColor:UIColor = UIColor(hex:0xCCCCCC)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        lineColor.setStroke()
        let path = UIBezierPath()
        path.lineWidth = UIScreen.main.scale > 1 ? 1 : 2
        let leftPoint = CGPoint(x:0, y:rect.height)
        let rightPoint = CGPoint(x:rect.width, y:rect.height)
        path.move(to: leftPoint)
        path.addLine(to: rightPoint)
        path.stroke()
    }
}

final class Line: UIView {
    @IBInspectable var lineColor:UIColor = UIColor(hex:0xCCCCCC) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var lineOpacity:CGFloat = 1.0 {
        didSet{
            lineColor = lineColor.withAlphaComponent(lineOpacity)
            self.setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        lineColor.setStroke()
        let path = UIBezierPath()
        path.lineWidth = UIScreen.main.scale > 1 ? 1 : 2
        let leftPoint = CGPoint(x:0, y:rect.height)
        let rightPoint = CGPoint(x:rect.width, y:rect.height)
        path.move(to: leftPoint)
        path.addLine(to: rightPoint)
        path.stroke()
    }
}

class LineTextField: UITextField {
    @IBInspectable var lineColor:UIColor = UIColor(hex:0xCCCCCC) {
        didSet{
            self.setNeedsDisplay()
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        lineColor.setStroke()
        let path = UIBezierPath()
        path.lineWidth = UIScreen.main.scale > 1 ? 1 : 2
        let leftPoint = CGPoint(x:0, y:rect.height - 1)
        let rightPoint = CGPoint(x:rect.width, y:rect.height - 1)
        path.move(to: leftPoint)
        path.addLine(to: rightPoint)
        path.stroke()
    }
}
