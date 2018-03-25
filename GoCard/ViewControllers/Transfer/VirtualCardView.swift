//
//  SendMoneyVirtualCardView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/15/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class VirtualCardView: UIView, UITextFieldDelegate, DropdownListviewDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var sendMoneyButton: UIButton!
    @IBOutlet var textfields: [FloatLabelTextField]!
    @IBOutlet var methodViews: [SendMethodCell]!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    private lazy var image = {
        return UIImage(named:Asset.personFlat.rawValue)
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        backgroundView.round(6)
        sendMoneyButton.round()
        sendMoneyButton.glowWithColor(color: UIColor.greenButton)
        sendMoneyButton.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        func config(_ tf: FloatLabelTextField, placeHolder textholder: String, activeTitle title: String) {
            tf.titleActiveTextColour = UIColor(hex:0x333333)
            tf.titleTextColour = UIColor(hex:0x999999)
            tf.attributedPlaceholder = NSAttributedString(string: textholder, attributes: [NSAttributedStringKey.font: UIFont.roboto(size: 14), NSAttributedStringKey.foregroundColor: UIColor(hex:0x999999), NSAttributedStringKey.kern: 1.9])
            tf.titleTextColour = UIColor.textDefault
            let acountLabel = tf.title
            acountLabel.text = title
            acountLabel.textColor = UIColor.textDefault
            acountLabel.characterSpacing(1.27, lineHeight: 11, withFont: UIFont.boldRoboto(size: 10))
            tf.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        }
        textfields[0].delegate = self
        config(textfields[0], placeHolder: "Choose Account (Optional)", activeTitle: "ACCOUNT NAME")
        config(textfields[1], placeHolder: "Insert Number (Optional)", activeTitle: "ACCOUNT NUMBER/EMAIL")
        config(textfields[2], placeHolder: "Input Reference (Optional)", activeTitle: "REFERENCE")
        
        methodViews.sort(by:{ return $0.tag < $1.tag })
        methodViews.forEach {
            $0.round(5)
            $0.addTarget(self, action: #selector(didTouchMethod(_:)), for: UIControlEvents.touchUpInside)
        }
        methodViews[0].isSelected = true
        paymentMethodLabel.characterSpacing(1.27, lineHeight: 11, withFont: UIFont.boldRoboto(size:10))
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTouchOnSelf(_:))))
    }
    
    @objc internal func didTouchOnSelf(_ sender: UIGestureRecognizer) {
        textfields.forEach{ if $0.canResignFirstResponder { $0.resignFirstResponder() } }
    }
    
    @objc internal func textFieldDidChanged(_ sender: UITextField) {
        sender.characterSpacing(1.9)
    }
    
    private func addShakeView() {
        guard let shakeView = Bundle.main.loadNibNamed("TransferPayingOptionsView", owner: nil, options: nil)?[1] as? ShakeView else {
            return
        }
        shakeView.frame = self.bounds
        self.addSubview(shakeView)
    }
    
    private func addQRCodeView() {
        guard let qrview = Bundle.main.loadNibNamed("TransferPayingOptionsView", owner: nil, options: nil)?[2] as? QRCodeView else {
            return
        }
        qrview.frame = self.bounds
        self.addSubview(qrview)
    }
    
    private func addTokenView() {
        guard let tokenView = Bundle.main.loadNibNamed("TransferPayingOptionsView", owner: nil, options: nil)?[3] as? TokenView else {
            return
        }
        tokenView.frame = self.bounds
        self.addSubview(tokenView)
    }
    
    @IBAction func didTouchMethod(_ sender: SendMethodCell) {
        if !sender.isSelected { sender.isSelected.toggle() }
        if sender.isSelected { methodViews.forEach { if $0 != sender { $0.isSelected = false } } }
        if let idx = methodViews.index(of: sender) {
            switch idx {
            case 0:
                break
            case 1:
                addShakeView()
                break
            case 2:
                addQRCodeView()
                break
            case 3:
                addTokenView()
                break
            default:
                break
            }
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let shouldShowDropDown = textField == textfields[0]
        if shouldShowDropDown {
            let dropdown = DropdownListview.instance()
            dropdown.delegate = self
            dropdown.show(withTarget: textField, inView: self)
        }
        return !shouldShowDropDown
    }
    
    internal func dropDownDidShow(_ dropdown: DropdownListview) { }
    internal func dropDownWillHide(_ dropdown: DropdownListview) { }
    internal func dropDownTextChanged(_ text: String?) {
        textfields[0].text = text
        textfields[0].characterSpacing(1.9)
    }
    internal func dropDownDidPick(_ account: Account) {
        textfields[0].text = account.name
        textfields[0].characterSpacing(1.9)
    }

    @IBAction func didTouchSendMoney(_ sender: Any) {
        UIViewController.topViewController()?.showWaiting()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            UIViewController.topViewController()?.hideWaiting()
        }
    }
}
