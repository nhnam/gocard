//
//  ProcessBar.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/10/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class ProcessBar: UIView {
    var backgroundLayer: CALayer!
    var loadedLayer: CAGradientLayer!
    var thumbLayer: CALayer!
    var percent: CGFloat = 0.1 {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeLayers()
        updateLayers()
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return super.awakeAfter(using: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayers()
    }
    
    private func initializeLayers() {
        backgroundLayer = CALayer()
        loadedLayer = CAGradientLayer()
        thumbLayer = CALayer()
        self.layer.addSublayer(backgroundLayer)
        self.layer.addSublayer(loadedLayer)
        self.layer.addSublayer(thumbLayer)
    }
    
    private func updateLayers() {
        let thumbH = self.bounds.size.height
        let barH = self.bounds.size.height/2
        backgroundLayer.cornerRadius = barH/2
        backgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        backgroundLayer.frame = CGRect(x:0, y:(thumbH - barH)/2, width:self.bounds.size.width, height:barH)
        
        loadedLayer.cornerRadius = barH/2
        loadedLayer.colors = [UIColor.blueLight.cgColor, UIColor.blueDeep.cgColor]
        loadedLayer.startPoint = CGPoint(x:0,y:0.5)
        loadedLayer.endPoint = CGPoint(x:1,y:0.5)
        loadedLayer.frame = CGRect(x:0, y:(thumbH - barH)/2, width:self.bounds.size.width*percent, height:barH)
        
        thumbLayer.backgroundColor = UIColor.blueDeep.cgColor
        thumbLayer.frame = CGRect(x:self.bounds.size.width*percent - thumbH/2, y:0, width:thumbH, height:thumbH)
        thumbLayer.round()
    }
}
