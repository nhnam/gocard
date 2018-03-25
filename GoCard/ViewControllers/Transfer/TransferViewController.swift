//
//  TransferViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import AudioToolbox

final class TransferViewController: BaseViewController {
    
    @IBOutlet weak var payButton: TransferSelectionButton!
    @IBOutlet weak var transferButton: TransferSelectionButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sendMoneyContainerView: UIView!
    private var payingValue:CGFloat = 2980.00 {
        didSet {
            if let attText = valueLabel.attributedText {
                let muAttText = NSMutableAttributedString(attributedString: attText)
                guard let valueString = Float(payingValue).decimalString() else { return }
                muAttText.mutableString.setString(String(format: "%@ \(Session.currency)", valueString))
                muAttText.setAttributes([NSAttributedStringKey.font: UIFont.mediumRoboto(size: 16)], range: NSRange(location:muAttText.length - 3, length:3))
                valueLabel.attributedText = muAttText
            } else {
                valueLabel.text = String(format: "%2.2f \(Session.currency)", payingValue)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        payingValue = payingValue + 0
    }

    private func setup() {
        self.title = "TRANSFER"
        payButton.characterSpacing(1.38, lineHeight: 14, withFont: UIFont.mediumRoboto(size:12))
        transferButton.characterSpacing(1.38, lineHeight: 14, withFont: UIFont.mediumRoboto(size:12))
        valueLabel.characterSpacing(1.14, lineHeight: 33, withFont: UIFont.mediumRoboto(size:28))
        payingValue = 2980.0
        guard let view = Bundle.main.loadNibNamed("TransferPayingOptionsView", owner: nil, options: nil)?.first as? VirtualCardView else { return }
        view.frame = sendMoneyContainerView.bounds
        sendMoneyContainerView.addSubview(view)
    }
    
    @IBAction func didTouchTransferButton(_ sender: TransferSelectionButton) {
        sender.isSelected = true
        payButton.isSelected = !sender.isSelected
    }
    
    @IBAction func didTouchPayButton(_ sender: TransferSelectionButton) {
        sender.isSelected = true
        transferButton.isSelected = !sender.isSelected
    }
    
    @IBAction func didTouchPlusButton(_ sender: Any) {
        payingValue += 10
    }
    
    @IBAction func didTouchMinusButton(_ sender: Any) {
        if payingValue - 10 >= 10 {
            payingValue -= 10
        }
    }
    
    @IBAction func didTouchRefreshButton(_ sender: Any) {
    }
    
    override var canBecomeFirstResponder: Bool {
        return UserDefaults.standard.bool(forKey: "waitingForShaking")
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
