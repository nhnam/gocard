//
//  BlurFullScreenView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/21/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class BlurFullScreenView: UIView {
    private var beginRect:CGRect = .zero
    private var endRect:CGRect = .zero
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    class func show(view aView:UIView, animated animation:Bool = true, completion complete: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow as UIWindow? else { return }
        let blurView = BlurFullScreenView(frame:window.bounds)
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        var frame = aView.frame
        frame.origin.x = (window.frame.size.width - frame.size.width) / 2.0
        frame.origin.y = (window.frame.size.height - frame.size.height) / 2.0
        blurView.addSubview(aView)
        aView.setNeedsLayout()
        window.addSubview(blurView)
        if animation {
            let frameState01 = frame.offsetBy(dx: 0, dy: window.frame.size.height)
            let frameState02 = frame.offsetBy(dx: 0, dy: -20)
            aView.frame = frameState01
            UIView.animateKeyframes(withDuration: 0.55, delay: 0, options: [UIViewKeyframeAnimationOptions.calculationModeLinear], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.35, animations: {
                    aView.frame = frameState02
                })
                UIView.addKeyframe(withRelativeStartTime: 0.35, relativeDuration: 0.2, animations: {
                    aView.frame = frame
                })
            }, completion: { (done:Bool) in
                aView.setNeedsLayout()
                complete?()
            })

        } else {
            aView.frame = frame
        }
    }
    
    class func hide(animated animation:Bool = true, completion complete: (() -> Void)? = nil) {
        guard let window = UIApplication.shared.keyWindow as UIWindow? else { return }
        guard let blurView = window.subviews.last as? BlurFullScreenView else { return }
        guard let view  = blurView.subviews.last else { return }
        if animation {
            let frame = view.frame
            let frameState01 = frame.offsetBy(dx: 0, dy: -20)
            let frameState02 = frame.offsetBy(dx: 0, dy: window.frame.size.height)
            UIView.animateKeyframes(withDuration: 0.55, delay: 0, options: [UIViewKeyframeAnimationOptions.calculationModeLinear], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                    view.frame = frameState01
                })
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.35, animations: {
                    view.frame = frameState02
                })
            }, completion: { (done:Bool) in
                blurView.removeFromSuperview()
                complete?()
            })
        } else {
            blurView.removeFromSuperview()
            complete?()
        }
    }
    
    class func hideCurrent() {
        guard let window = UIApplication.shared.keyWindow as UIWindow? else { return }
        guard let blurView = window.subviews.last as? BlurFullScreenView else { return }
        blurView.isHidden = true
    }
    class func showHiddenCurrent() {
        guard let window = UIApplication.shared.keyWindow as UIWindow? else { return }
        guard let blurView = window.subviews.last as? BlurFullScreenView else { return }
        blurView.isHidden = false
    }
}
