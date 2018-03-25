//
//  TransactionDetailViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/28/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class TransactionDetailViewController: BaseViewController {

    @IBOutlet weak var containerRoundedView: UIView!
    @IBOutlet weak var viewDetailButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        containerRoundedView.roundBorder(9, borderWidth: 1.0, borderColor: UIColor.white.withAlphaComponent(0.5))
        viewDetailButton.round()
    }
    @IBAction func didTouchViewDetail(_ sender: Any) {
    }
    
    @IBAction func didTouchCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
