//
//  BaseViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    private var titleLabel:UILabel?
    override open var title: String? {
        didSet{
            titleLabel?.attributedText = NSAttributedString(string: title ?? "", attributes: [NSKernAttributeName: 2.0, NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.navigationBarTitle])
            titleLabel?.sizeToFit()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel = UILabel()
        titleLabel?.text = ""
        titleLabel?.attributedText = NSAttributedString(string: "", attributes: [NSKernAttributeName: 2.0, NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.navigationBarTitle])
        titleLabel?.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
}
