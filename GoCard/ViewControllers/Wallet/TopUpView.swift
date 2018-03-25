//
//  TopUpView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/20/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class TopUpView: UIView {

    @IBOutlet weak var topupTitle: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var walletSegments: [WalletSelectionControl]!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var editableValueTextfield: UITextField!
    @IBOutlet weak var dropdownButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var whiteBgView: UIView!
    @IBOutlet weak var checkDoneEditButton: UIButton!
    private var activeView:UIView?
    private var value:CGFloat = Session.amount {
        didSet{
            if let attText = valueLabel.attributedText {
                let muAttText = NSMutableAttributedString(attributedString: attText)
                guard let valueString = Float(value).decimalString() else { return }
                editableValueTextfield.attributedText = valueString.apply(
                    [NSAttributedStringKey.font: UIFont.mediumRoboto(size: 28),
                     NSAttributedStringKey.kern: 1.14])
                muAttText.mutableString.setString(String(format: "%@ \(Session.currency)", valueString))
                let attributes = [NSAttributedStringKey.font: UIFont.mediumRoboto(size: 16)]
                let range = NSRange(location:muAttText.length - 3, length:3)
                muAttText.setAttributes(attributes, range: range)
                valueLabel.attributedText = muAttText
            } else {
                valueLabel.text = String(format: "%2.2f \(Session.currency)", value)
                editableValueTextfield.text = String(format: "%2.2f \(Session.currency)", value)
            }
        }
    }
    private var isEditing:Bool = false {
        didSet{
            valueLabel.isHidden = isEditing
            dropdownButton.isHidden  = isEditing
            editableValueTextfield.isHidden = !isEditing
            checkDoneEditButton.isHidden = !isEditing
            if !isEditing { editableValueTextfield.resignFirstResponder() }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        whiteBgView.roundBorder(20, borderWidth: 1.0, borderColor: UIColor.borderColor)
        topupTitle.characterSpacing(0.93, lineHeight: 24, withFont: UIFont.boldRoboto(size:20))
        valueLabel.characterSpacing(1.14, lineHeight: 33, withFont: UIFont.mediumRoboto(size:28))
        valueLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTouchValueLabel(_:))))
        valueLabel.isUserInteractionEnabled = true
        walletSegments.sort { return $0.tag < $1.tag }
        walletSegments.forEach {
            $0.round(9)
            $0.addTarget(self, action: #selector(didTouchSegment(_:)), for: UIControlEvents.touchUpInside)
        }
        actionButton.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        actionButton.round()
        actionButton.tintColor = UIColor.white
        actionButton.isHidden = true
        value = Session.amount
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.35) { 
            self.didTouchSegment(self.walletSegments[0])
        }
        checkDoneEditButton.round()
        checkDoneEditButton.backgroundColor = UIColor.blueButton
        isEditing = false
        editableValueTextfield.keyboardType = .decimalPad
    }
    
    private func addCreditCardView() {
        guard let view = Bundle.main.loadNibNamed("TopUpCreditCard", owner: self, options: nil)?.first as? TopUpCreditCard else { return }
        containerView.addSubview(view)
        view.frame = containerView.bounds
        activeView = view
        actionButton.setImage(nil, for: .normal)
        actionButton.setImage(nil, for: .selected)
        actionButton.setTitle("Upload", for: .normal)
        actionButton.setTitle("Upload", for: .selected)
        actionButton.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        actionButton.isHidden = false
        actionButton.setNeedsDisplay()
    }
    private func addApplePayView() {
        actionButton.setAttributedTitle(nil, for: .normal)
        actionButton.setAttributedTitle(nil, for: .selected)
        actionButton.setTitle(nil, for: .normal)
        actionButton.setTitle(nil, for: .selected)
        actionButton.setImage(UIImage(named:"Apple Pay Button"), for: .normal)
        actionButton.setImage(UIImage(named:"Apple Pay Button"), for: .selected)
        actionButton.isHidden = false
    }
    private func addBankTransferView() {
        guard let view = Bundle.main.loadNibNamed("TopUpBankTransfer", owner: self, options: nil)?.first as? TopUpBankTransfer else { return }
        containerView.addSubview(view)
        view.frame = containerView.bounds
        activeView = view
        actionButton.setImage(nil, for: .normal)
        actionButton.setImage(nil, for: .selected)
        actionButton.setTitle("Activate Account", for: .normal)
        actionButton.setTitle("Activate Account", for: .selected)
        actionButton.characterSpacing(1.5, lineHeight: 16, withFont: UIFont.boldRoboto(size:14))
        actionButton.isHidden = false
        actionButton.setNeedsDisplay()
    }
    
    @IBAction func didTouchSegment(_ sender: WalletSelectionControl) {
        if !sender.isSelected { sender.isSelected.toggle() }
        if sender.isSelected { walletSegments.forEach { if $0 != sender { $0.isSelected = false } } }
        activeView?.endEditing(true)
        activeView?.removeFromSuperview()
        switch sender.tag {
        case 101:
            addCreditCardView()
            break
        case 102:
            addApplePayView()
            break
        case 103:
            addBankTransferView()
            break
        default:
            break
        }
    }
    
    @objc func didTouchValueLabel(_ sender: UIGestureRecognizer) {
        isEditing = true
        if editableValueTextfield.canBecomeFirstResponder {
            editableValueTextfield.becomeFirstResponder()
        }
    }

    @IBAction func didTouchCloseButton(_ sender: Any) {
        BlurFullScreenView.hide()
    }
    
    @IBAction func didTouchDropdownButton(_ sender: Any) {
    
    }
    
    @IBAction func didTouchCheckDoneButton(_ sender: Any) {
        let newValue = Float.fromDecimalString(editableValueTextfield.text ?? "00.00")
        value = CGFloat(newValue)
        isEditing = false
    }
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let newValue = Float.fromDecimalString(editableValueTextfield.text ?? "00.00")
        value = CGFloat(newValue)
        isEditing = false
        return false
    }
    @IBAction func didTouchActionButton(_ sender: Any) {
        UIViewController.topViewController()?.showWaiting()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            UIViewController.topViewController()?.hideWaiting()
        }
    }
}
