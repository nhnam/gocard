//
//  LockCardCell.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/26/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class LockCardCell: UITableViewCell {

    @IBOutlet weak var lockButton:UIButton!
    @IBOutlet var pins: [PinTextfield]!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var unlockContainer: UIView!
    
    weak var viewcontroller:OptionViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    internal var cardLocked:Bool = true {
        didSet{
            unlockContainer.isHidden = cardLocked
            lockButton.isHidden = !cardLocked
        }
    }
    
    private func setup() {
        [lockButton, unlockButton, discardButton].forEach {
            $0?.round()
            $0?.glowWithColor(color: UIColor.blueButton)
        }
        pins.forEach {
            $0.keyboardType = .numberPad
            $0.addTarget(self, action: #selector(pinsValueChanged(_:)), for: .editingChanged)
        }
        cardLocked = true
    }
    
    @IBAction func didTouchTemporaryLock(_ sender: Any) {
        lockButton.peek {
            self.cardLocked = false
        }
    }
    @IBAction func didTouchUnlock(_ sender: Any) {
        unlockButton.peek {
            self.cardLocked = true
        }
    }
    @IBAction func didTouchDiscard(_ sender: Any) {
        discardButton.peek{
            self.viewcontroller?.removeCardCell()
        }
    }
}

extension LockCardCell {
    internal func pinsValueChanged(_ sender: PinTextfield) {
        if sender.text?.isEmpty ?? true{
            sender.back()
        } else {
            sender.next()
        }
    }
}
