//
//  EnterPinViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/27/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class EnterPinViewController: BaseViewController {
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet var pins: [PinTextfield]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        self.title = "ENTER PIN"
        self.confirmButton.round()
        pins.forEach {
            $0.keyboardType = .numberPad
            $0.addTarget(self, action: #selector(pinsValueChanged(_:)), for: .editingChanged)
        }
    }
    
    @IBAction func didTouchConfirmButton(_ sender: Any) {
        // fake saving
        func onSavingSuccessful() { _ = self.navigationController?.popToRootViewController(animated: true) }
        func onSavingError() { }
        showWaiting()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) { [unowned self] in
            self.hideWaiting()
            onSavingSuccessful()
        }
    }
    
}

extension EnterPinViewController {
    @objc internal func pinsValueChanged(_ sender: PinTextfield) {
        if sender.text?.isEmpty ?? true{
            sender.back()
        } else {
            sender.next()
        }
    }
}
