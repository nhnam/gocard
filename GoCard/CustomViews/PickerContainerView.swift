//
//  PickerContainerView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/30/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class PickerContainerView: UIView {
    class func show(_ picker:UIPickerView, onClose:((Bool)->())?) {
        guard let window = UIApplication.shared.keyWindow as UIWindow? else { return }
        let blurView = PickerContainerView(frame:window.bounds)
        blurView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        window.addSubview(blurView)
        blurView.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: blurView, attribute: .centerX, relatedBy: .equal, toItem: picker, attribute: .centerX, multiplier: 1.0, constant: 0)
        centerX.identifier = "centerX"
        let bottom = NSLayoutConstraint(item: blurView, attribute: .bottom, relatedBy: .equal, toItem: picker, attribute: .bottom, multiplier: 1.0, constant: 0)
        bottom.identifier = "bottom"
        let leading = NSLayoutConstraint(item: blurView, attribute: .leading, relatedBy: .equal, toItem: picker, attribute: .leading, multiplier: 1.0, constant: 0)
        leading.identifier = "leading"
        let trailing = NSLayoutConstraint(item: blurView, attribute: .trailing, relatedBy: .equal, toItem: picker, attribute: .trailing, multiplier: 1.0, constant: 0)
        trailing.identifier = "trailing"
        blurView.addConstraints([centerX, bottom,trailing,leading])
        
        let doneButton = UIButton(frame: CGRect(x: blurView.frame.size.width - (60+20),
                                                y: blurView.frame.size.height - picker.frame.size.height + 20, width: 60, height: 40))
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.blueButton, for: .normal)
        doneButton.addTarget(blurView, action: #selector(didTouchDone(_:)), for: .touchUpInside)
        blurView.addSubview(doneButton)
        
        let pickerHeight = picker.frame.size.height
        blurView.constraints.forEach {
            if $0.identifier == "bottom" {
               $0.constant = -(pickerHeight + 20)
            }
        }
        picker.layer.shadowColor = UIColor.blueLight.cgColor
        picker.layer.shadowRadius = 6
        picker.layer.shadowOffset = CGSize.zero
        picker.layer.shadowOpacity = 1.0
        picker.layer.masksToBounds = false
        blurView.layoutIfNeeded()
        UIView.animateKeyframes(withDuration: 0.55, delay: 0, options: [UIViewKeyframeAnimationOptions.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.35, animations: {
                blurView.constraints.forEach {
                    if $0.identifier == "bottom" {
                        $0.constant = 20
                    }
                }
                blurView.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.35, relativeDuration: 0.2, animations: {
                blurView.constraints.forEach {
                    if $0.identifier == "bottom" {
                        $0.constant = 0
                    }
                }
                blurView.layoutIfNeeded()
            })
        }, completion: { (done:Bool) in
            blurView.layoutIfNeeded()
            print("Picker shown")
        })
    }
    
    func didTouchDone(_ sender: UIButton?) {
        PickerContainerView.close()
    }
    
    class func close() {
        guard let window = UIApplication.shared.keyWindow as UIWindow? else { return }
        guard let blurView = window.subviews.last as? PickerContainerView else { return }
        blurView.subviews.forEach{ if $0 is UIButton { $0.removeFromSuperview() } }
        guard let picker  = blurView.subviews.last else { return }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "currenciesPicker_willClose"), object: picker)
        let pickerHeight = picker.frame.size.height
        UIView.animateKeyframes(withDuration: 0.55, delay: 0, options: [UIViewKeyframeAnimationOptions.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                blurView.constraints.forEach {
                    if $0.identifier == "bottom" {
                        $0.constant = 20
                    }
                }
                blurView.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.35, animations: {
                blurView.constraints.forEach {
                    if $0.identifier == "bottom" {
                        $0.constant = -( pickerHeight + 20)
                    }
                }
                blurView.layoutIfNeeded()
            })
        }, completion: { (done:Bool) in
            blurView.removeFromSuperview()
            print("Picker closed")
        })
    }
}
