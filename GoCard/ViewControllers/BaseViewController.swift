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
            titleLabel?.attributedText = NSAttributedString(string: title ?? "", attributes: [NSAttributedStringKey.kern: 2.0, NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.navigationBarTitle])
            titleLabel?.sizeToFit()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel = UILabel()
        titleLabel?.text = ""
        titleLabel?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedStringKey.kern: 2.0, NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.navigationBarTitle])
        titleLabel?.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
}
