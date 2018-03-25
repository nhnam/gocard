//
//  TransactionViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import RealmSwift

final class TransactionViewController: BaseViewController {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var timeTable: UITableView!
    @IBOutlet weak var mainTable: UITableView!
    internal var transactions:[String:[Transaction]] = [:]
    internal var filteredTransactions:[Transaction] = []
    internal var notificationToken: NotificationToken?
    internal var transactionDetailVC:TransactionDetailViewController?
    internal var group1:[Transaction] = []
    internal var group2:[Transaction] = []
    internal var group3:[Transaction] = []
    internal var group1Filtered:[Transaction] = []
    internal var group2Filtered:[Transaction] = []
    internal var group3Filtered:[Transaction] = []
    internal var value:CGFloat = 2980.19 {
        didSet{
            if let attText = valueLabel.attributedText {
                let muAttText = NSMutableAttributedString(attributedString: attText)
                guard let valueString = Float(value).decimalString() else { return }
                muAttText.mutableString.setString(String(format: "%@ \(Session.currency)", valueString))
                muAttText.setAttributes([NSFontAttributeName: UIFont.mediumRoboto(size: 16)], range: NSRange(location:muAttText.length - 3, length:3))
                valueLabel.attributedText = muAttText
            } else {
                valueLabel.text = String(format: "%2.2f \(Session.currency)", value)
            }
        }
    }
    
    internal var activeFilterView:UIView? {
        didSet{
            if activeFilterView != nil {
                // change filter button to OK
            } else {
                // revert to filter button
            }
        }
    }
    
    internal var dateFrom:Date = Date()
    internal var dateTo:Date = Date()
    internal var datePicker = MIDatePicker.getFromNib()
    internal var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchField.layer.masksToBounds = false
        searchField.layer.shadowRadius = 5.0
        searchField.layer.shadowOpacity = 0.55
        searchField.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchField.layer.shadowColor = UIColor.blueLight.cgColor
        searchField.setNeedsDisplay()
        value += 0
        let allTransactions = try! Realm().objects(Transaction.self).sorted(byKeyPath: "id", ascending:true)
        group1 = allTransactions.filter({ (item:Transaction) -> Bool in
            return item.group == "Mar 4, 2017"
        })
        print(group1.count)
        group2 = allTransactions.filter({ (item:Transaction) -> Bool in
            return item.group == "Mar 2, 2017"
        })
        print(group2.count)
        group3 = allTransactions.filter({ (item:Transaction) -> Bool in
            return item.group == "Mar 1, 2017"
        })
        print(group3.count)
    }
    
    private func setup() {
        self.title = "TRANSACTIONS"
        value = 2980.00
        setupDatePicker()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        searchField.round(5.0)
        searchField.addImageLeftView(#imageLiteral(resourceName: "Search Icon"))
        guard let attributedString = searchField.attributedText else { return }
        searchField.attributedPlaceholder = attributedString
        let attributes = attributedString.attributes(at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: attributedString.length))
        searchField.defaultTextAttributes = attributes
        searchField.typingAttributes = attributes
        searchField.text = ""
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(searchBarDidChanged(_:)), for: .editingChanged)
        
        let mainSb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = mainSb.instantiateViewController(withIdentifier: "TransactionDetailViewController") as? TransactionDetailViewController {
            transactionDetailVC = vc
            _ = vc.view
        }
    }
    
    private func setupDatePicker() {
        datePicker.delegate = self
        datePicker.config.startDate = Date()
        datePicker.config.animationDuration = 0.25
        datePicker.config.cancelButtonTitle = "Cancel"
        datePicker.config.confirmButtonTitle = "Confirm"
        datePicker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        datePicker.config.headerBackgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        datePicker.config.confirmButtonColor = UIColor(red: 32/255.0, green: 146/255.0, blue: 227/255.0, alpha: 1)
        datePicker.config.cancelButtonColor = UIColor(red: 32/255.0, green: 146/255.0, blue: 227/255.0, alpha: 1)
    }
    
    @IBAction func didTouchFilter(_ sender: Any) {
        if activeFilterView != nil {
            hideFilter()
        }else {
            guard let filterView = Bundle.main.loadNibNamed("FiltersView", owner: self, options: nil)?.first as? FiltersView else { return }
            filterView.frame = mainTable.frame
            showFilter(filterView)
        }
    }
}

extension TransactionViewController:UITextFieldDelegate {
    internal func searchBarDidChanged(_ sender: UITextField?) {
        if let key = searchField.text {
            group1Filtered.removeAll()
            group1Filtered = group1.filter { $0.title.contains(key) || $0.detail.contains(key)}
            group2Filtered.removeAll()
            group2Filtered = group2.filter { $0.title.contains(key) || $0.detail.contains(key)}
            group3Filtered.removeAll()
            group3Filtered = group3.filter { $0.title.contains(key) || $0.detail.contains(key)}
            mainTable.reloadData()
        } else {
            resetFilter()
        }
    }
    
    internal func textFieldShouldClear(_ textField: UITextField) -> Bool {
        resetFilter()
        return true
    }
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.canResignFirstResponder { return false }
        textField.resignFirstResponder()
        mainTable.reloadData()
        return true
    }
}

extension TransactionViewController {
    internal func getMonthFromInt(_ value:Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let dateString = String(format:"%02d", value)
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "MMM"
        let monthString = dateFormatter.string(from: date)
        return monthString.uppercased()
    }
    
    internal func showFilter(_ filterview:UIView, completion complete: (() -> Void)? = nil) {
        let frame = mainTable.frame
        let frameState01 = frame.offsetBy(dx: 0, dy: frame.size.height)
        let frameState02 = frame.offsetBy(dx: 0, dy: -20)
        activeFilterView = filterview
        self.view.addSubview(filterview)
        filterview.frame = frameState01
        UIView.animateKeyframes(withDuration: 0.55, delay: 0, options: [UIViewKeyframeAnimationOptions.calculationModeLinear], animations: { [unowned filterview] in
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.35, animations: {  [unowned filterview] in
                filterview.frame = frameState02
            })
            UIView.addKeyframe(withRelativeStartTime: 0.35, relativeDuration: 0.2, animations: { [unowned filterview] in
                filterview.frame = frame
            })
            }, completion: {  [unowned filterview] (done:Bool) in
                filterview.setNeedsLayout()
                complete?()
        })
    }
    
    internal func hideFilter(completion complete: (() -> Void)? = nil) {
        if let filterview = activeFilterView {
            let frame = filterview.frame
            let frameState01 = frame.offsetBy(dx: 0, dy: -20)
            let frameState02 = frame.offsetBy(dx: 0, dy: filterview.frame.size.height)
            UIView.animateKeyframes(withDuration: 0.55, delay: 0, options: [UIViewKeyframeAnimationOptions.calculationModeLinear], animations: { [unowned filterview] in
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: { [unowned filterview] in
                    filterview.frame = frameState01
                })
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.35, animations: { [unowned filterview] in
                    filterview.frame = frameState02
                })
                }, completion: { [unowned self] (done:Bool) in
                    filterview.removeFromSuperview()
                    self.activeFilterView = nil
                    complete?()
            })
        }
    }
}

extension TransactionViewController: MIDatePickerDelegate {
    internal func miDatePicker( _ amDatePicker: MIDatePicker, didSelect date: Date) {
        print("selected date: \(date)")
    }
    internal func miDatePickerDidCancelSelection( _ amDatePicker: MIDatePicker) {
        // NOP
    }
}
