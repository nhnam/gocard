//
//  TokenView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/16/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class TokenView: UIView {
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var backgroundView: UIView?
    @IBOutlet weak var tokenView: UILabel?
    @IBOutlet weak var copyButton: UIButton?
    @IBOutlet weak var sendButton: UIButton?
    @IBOutlet var otpMethods: [OTPAppSelectionControl]?
    @IBOutlet weak var title:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        title.characterSpacing(1.27, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        backgroundView?.round(6)
        backButton?.round()
        backButton?.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        tokenView?.round()
        copyButton?.round()
        sendButton?.round()
        otpMethods?.sort(by:{ return $0.tag < $1.tag })
        otpMethods?.forEach {
            $0.round(5)
            $0.addTarget(self, action: #selector(didTouchMethod(_:)), for: UIControlEvents.touchUpInside)
        }
    }
    
    @IBAction func didTouchMethod(_ sender: OTPAppSelectionControl) {
        if !sender.isSelected { sender.isSelected.toggle() }
        if sender.isSelected { otpMethods?.forEach { if $0 != sender { $0.isSelected = false } } }
    }
    @IBAction func didTouchCopy(_ sender: Any) {
        UIPasteboard.general.string = tokenView?.text
    }
    @IBAction func didTouchSend(_ sender: Any) {
        var hasMethodSelect = false
        otpMethods?.forEach {
            if $0.isSelected {
                UIViewController.topViewController()?.showWaiting()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                    UIViewController.topViewController()?.hideWaiting()
                }
                hasMethodSelect = true
            }
        }
        if !hasMethodSelect {
            print("Please select method first !")
        }
    }
    @IBAction func didTouchBack(_ sender: Any) {
        self.removeFromSuperview()
    }
}
