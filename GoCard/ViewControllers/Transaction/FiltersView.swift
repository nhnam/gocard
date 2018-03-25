//
//  FiltersView.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/25/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

class FiltersView: UIView {

    @IBOutlet var columnViews: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        columnViews.forEach {
            $0.clipsToBounds = true
            $0.roundBorder(1, borderWidth: 1.0, borderColor: UIColor(hex:0x979797))
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowRadius = 2.0
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            $0.layer.shadowOpacity = 0.9
            $0.layer.masksToBounds = false
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        columnViews.forEach { $0.setNeedsDisplay() }
    }
    
    // Category Picker
    @IBAction func didTouchCategoryPicker(_ sender: Any) {
    }
    // From Pickers
    @IBAction func didTouchDayFromPicker(_ sender: Any) {
    }
    @IBAction func didTouchMonthFromPicker(_ sender: Any) {
    }
    @IBAction func didTouchYearFromPicker(_ sender: Any) {
    }
    // To Pickers
    @IBAction func didTouchDayToPicker(_ sender: Any) {
    }
    @IBAction func didTouchMonthToPicker(_ sender: Any) {
    }
    @IBAction func didTouchYearToPicker(_ sender: Any) {
    }
}
