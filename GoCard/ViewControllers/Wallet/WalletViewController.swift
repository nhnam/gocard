//
//  WalletViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class WalletViewController: BaseViewController {

    @IBOutlet weak var youSendLabel: UILabel!
    @IBOutlet weak var receptientsGetLabel: UILabel!
    @IBOutlet weak var valueSend: UILabel!
    @IBOutlet weak var valueGet: UILabel!
    @IBOutlet weak var currencySend: UILabel!
    @IBOutlet weak var currencyGet: UILabel!
    @IBOutlet weak var dropButtonSend: UIButton!
    @IBOutlet weak var dropButtonGet: UIButton!
    @IBOutlet weak var reloadBackgroundView: UIView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var valueSaved: UILabel!
    @IBOutlet var segments: [SegmentControlItem]!
    @IBOutlet weak var scrollView: UIScrollView!
    private var activeView:UIView?
    
    @IBOutlet weak var valueSendEditfield: UITextField!
    @IBOutlet weak var valueReceiveEditfield: UITextField!
    
    internal var currenciesUnit = ["SGD", "THB", "JPY", "USD"]
    internal var currenciesName = ["Singapore Dollar", "Thai Bath", "Japanese Yen", "United States Dollar"]
    internal var activeDropDown: UIButton?
    lazy internal var currencyPicker: UIPickerView? = {
        var picker = UIPickerView()
        picker.delegate = self
        picker.backgroundColor = .white
        return picker
    }()
    
    lazy internal var balanceView: UIView = {
        guard let view = Bundle.main.loadNibNamed("BalanceView", owner: self, options: nil)?.first as? BalanceView else { return UIView()}
        self.scrollView.contentSize = self.scrollView.frame.size
        let size = self.scrollView.frame.size
        view.frame = CGRect(x: 10, y: 10, width: size.width - 20, height: size.height - 20)
        view.round(5.0)
        return view
    }()
    
    lazy internal var rateView: UIView = {
        guard let view = Bundle.main.loadNibNamed("RateView", owner: self, options: nil)?.first as? RateView else { return UIView() }
        self.scrollView.contentSize = self.scrollView.frame.size
        let size = self.scrollView.frame.size
        view.frame = CGRect(x: 10, y: 10, width: size.width - 20, height: size.height - 20)
        view.round(5.0)
        return view
    }()
    
    internal var isEditingSend:Bool = false {
        didSet{
            valueSend.isHidden = isEditingSend
            dropButtonSend.isHidden  = isEditingSend
            valueSendEditfield.isHidden = !isEditingSend
            if !isEditingSend {
                valueSendEditfield.resignFirstResponder()
            } else {
                valueSendEditfield.becomeFirstResponder()
            }
        }
    }
    
    internal var isEditingReceive:Bool = false {
        didSet{
            valueGet.isHidden = isEditingReceive
            dropButtonGet.isHidden  = isEditingReceive
            valueReceiveEditfield.isHidden = !isEditingReceive
            if !isEditingReceive {
                valueReceiveEditfield.resignFirstResponder()
            } else {
                valueSendEditfield.becomeFirstResponder()
            }
        }
    }
    
    internal var rate:Float = 1.0 {
        didSet{
            getValue = sendValue * CGFloat(rate)
            reloadBalance()
        }
    }
    internal var exUnit = "THB"
    
    internal var sendValue:CGFloat = 120.00 {
        didSet{
            Session.amount = sendValue
            if let attText = valueSend.attributedText {
                let muAttText = NSMutableAttributedString(attributedString: attText)
                guard let valueString = Float(sendValue).decimalString() else { return }
                valueSendEditfield.attributedText = valueString.apply([NSFontAttributeName: UIFont.mediumRoboto(size: 28), NSKernAttributeName: 1.14, NSForegroundColorAttributeName: valueSend.textColor])
                muAttText.mutableString.setString(String(format: "%@ \(Session.currency)", valueString))
                muAttText.setAttributes([NSFontAttributeName: UIFont.mediumRoboto(size: 16)], range: NSRange(location:muAttText.length - 3, length:3))
                valueSend.attributedText = muAttText
            } else {
                valueSend.text = String(format: "%2.2f \(Session.currency)", sendValue)
                valueSendEditfield.text = String(format: "%2.2f \(Session.currency)", sendValue)
            }
            reloadBalance()
        }
    }
    
    internal var getValue:CGFloat = 2980.19 {
        didSet{
            if let attText = valueGet.attributedText {
                let muAttText = NSMutableAttributedString(attributedString: attText)
                guard let valueString = Float(getValue).decimalString() else { return }
                valueReceiveEditfield.attributedText = valueString.apply([NSFontAttributeName: UIFont.mediumRoboto(size: 28), NSKernAttributeName: 1.14, NSForegroundColorAttributeName: valueGet.textColor])
                muAttText.mutableString.setString(String(format: "%@ \(exUnit)", valueString))
                muAttText.setAttributes([NSFontAttributeName: UIFont.mediumRoboto(size: 16)], range: NSRange(location:muAttText.length - 3, length:3))
                valueGet.attributedText = muAttText
            } else {
                valueGet.text = String(format: "%2.2f \(exUnit)", getValue)
                valueReceiveEditfield.text = String(format: "%2.2f \(exUnit)", getValue)
            }
            reloadBalance()
        }
    }
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.title = "WALLET"
        youSendLabel.characterSpacing(1.15, lineHeight: 11, withFont: UIFont.mediumRoboto(size: 10))
        receptientsGetLabel.characterSpacing(1.15, lineHeight: 11, withFont: UIFont.mediumRoboto(size: 10))
        valueSend.characterSpacing(1.14, lineHeight: 33, withFont: UIFont.mediumRoboto(size: 28))
        valueGet.characterSpacing(1.14, lineHeight: 33, withFont: UIFont.mediumRoboto(size: 28))
        currencyGet.characterSpacing(1.14, lineHeight: 11, withFont: UIFont.roboto(size: 10))
        currencySend.characterSpacing(1.14, lineHeight: 11, withFont: UIFont.roboto(size: 10))
        valueSaved.characterSpacing(0.55, lineHeight: 13, withFont: UIFont.roboto(size: 11))
        reloadBackgroundView.round()
        valueSaved.round()
        segments.forEach {
            $0.addTarget(self, action: #selector(didTouchSegment(_:)), for: UIControlEvents.touchUpInside)
        }
        segments[0].isSelected = true
        
        sendValue = 120.00
        getValue = 2980.19
        valueSend.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTouchValueSendLabel(_:))))
        valueSend.isUserInteractionEnabled = true
        valueGet.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTouchValueGetLabel(_:))))
        valueGet.isUserInteractionEnabled = true
        valueSendEditfield.delegate = self
        valueReceiveEditfield.delegate = self
        rate = DataCenter.rate(currency: "THB")
        addBalanceView()
        NotificationCenter.default.addObserver(self, selector: #selector(pickerWillClose(_:)), name: NSNotification.Name(rawValue:"currenciesPicker_willClose"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(exchangeDidUpdated(_:)), name: NSNotification.Name(rawValue:"ratesDidUpdated"), object: nil)
    }
    
    internal func didTouchValueSendLabel(_ sender: UIGestureRecognizer) {
        isEditingSend = true
    }
    
    internal func didTouchValueGetLabel(_ sender: UIGestureRecognizer) {
        isEditingReceive = true
    }
    
    private func addBalanceView() {
        scrollView.addSubview(balanceView)
        activeView = balanceView
    }
    private func addGraphImageView(){
        let graphView = UIImageView(image: #imageLiteral(resourceName: "Graph Table"))
        graphView.contentMode = .center
        scrollView.contentSize = scrollView.frame.size
        let size = scrollView.frame.size
        graphView.frame = CGRect(x: 10, y: 10, width: size.width - 20, height: size.height - 20)
        graphView.round(5.0)
        
        scrollView.addSubview(graphView)
        activeView = graphView
    }
    private func addGraphView() {
        guard let graphView = Bundle.main.loadNibNamed("GraphView", owner: self, options: nil)?.first as? GraphView else { return }
        scrollView.contentSize = scrollView.frame.size
        let size = scrollView.frame.size
        graphView.frame = CGRect(x: 10, y: 10, width: size.width - 20, height: size.height - 20)
        scrollView.addSubview(graphView)
        graphView.round(5.0)
        graphView.showChart()
        activeView = graphView
    }
    private func addRateView() {
        scrollView.addSubview(rateView)
        activeView = rateView
    }
    
    @IBAction func didTouchSegment(_ sender: SegmentControlItem) {
        if !sender.isSelected { sender.isSelected.toggle() }
        if sender.isSelected { segments.forEach { if $0 != sender { $0.isSelected = false } } }
        activeView?.removeFromSuperview()
        switch sender.tag {
        case 101:
            addBalanceView()
            break
        case 102:
            // addGraphView()
            addGraphImageView()
            break
        case 103:
            addRateView()
            break
        default:
            break
        }
    }
    
    @IBAction func didTouchSendDropdown(_ sender: UIButton) {
        if let picker = currencyPicker {
            activeDropDown = sender
            PickerContainerView.show(picker, onClose: nil)
        }
    }
    @IBAction func didTouchGetDropdown(_ sender: UIButton) {
        if let picker = currencyPicker {
            activeDropDown = sender
            PickerContainerView.show(picker, onClose: nil)
        }
    }
    @IBAction func didTouchExchangeButton(_ sender: Any) {
        reloadButton.rotate(in: 1.0)
        DataCenter.fetchExchangeRate(Session.currency, completion: { [weak self] (data:JSON) in
            self?.reloadValues()
        }, failed: nil)
        guard let sendWallet = realm.object(ofType: Wallet.self, forPrimaryKey: Session.currency), let receiptWallet = realm.object(ofType: Wallet.self, forPrimaryKey: exUnit) else { return }
        try! realm.write {
            sendWallet.amount -= Float(sendValue)
            receiptWallet.amount += Float(getValue)
        }
    }
    @IBAction func didTouchSendMoneyBarButton(_ sender: Any) {
        guard let view = Bundle.main.loadNibNamed("TopUpView", owner: self, options: nil)?.first as? TopUpView else { return }
        BlurFullScreenView.show(view: view)
    }
    
    internal func pickerWillClose(_ notification: Notification) {
        reloadValues()
    }
    internal func exchangeDidUpdated(_ notification: Notification) {
        reloadValues()
    }
    
    internal func reloadValues() {
        let rates = DataCenter.ratesFor(base: Session.currency)
        rates.forEach { (rateItem:DataCenter.Rate) in
            if rateItem.unit == exUnit {
                rate = rateItem.rateValue
                return
            }
        }
    }
    internal func reloadBalance() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"exchangeDidUpdated"), object: nil)
    }
}

extension WalletViewController: UITextFieldDelegate {
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.canResignFirstResponder { return false }
        
        if textField == valueSendEditfield {
            isEditingSend = false
            let newValue = Float.fromDecimalString(valueSendEditfield.text ?? "00.00")
            sendValue = CGFloat(newValue)
            getValue = sendValue * CGFloat(rate)
        }
        else if textField == valueReceiveEditfield {
            isEditingReceive = false
            let newValue = Float.fromDecimalString(valueReceiveEditfield.text ?? "00.00")
            getValue = CGFloat(newValue)
            sendValue = getValue / CGFloat(rate)
        }
        
//        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: [.calculationModeLinear], animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.35, animations: {
//                textField.resignFirstResponder()
//            })
//        }, completion: nil)
        
        return false
    }
    
    internal func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension WalletViewController:  UIPickerViewDataSource, UIPickerViewDelegate {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenciesUnit.count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedText = NSMutableAttributedString(string: currenciesUnit[row])
        attributedText.addAttributes([NSForegroundColorAttributeName: UIColor.textDefault,
                                      NSFontAttributeName: UIFont.mediumRoboto(size: 28),
                                      NSKernAttributeName: 1.14], range: NSRange(location: 0, length: attributedText.length))
        return attributedText
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if activeDropDown == dropButtonSend {
            Session.currency = currenciesUnit[row]
            currencySend.text = currenciesName[row]
            currencySend.characterSpacing(1.14, lineHeight: 11, withFont: UIFont.roboto(size: 10))
            sendValue = sendValue + 0
        } else if activeDropDown == dropButtonGet {
            exUnit = currenciesUnit[row]
            currencyGet.text = currenciesName[row]
            currencyGet.characterSpacing(1.14, lineHeight: 11, withFont: UIFont.roboto(size: 10))
            getValue = getValue + 0
        }
    }
}
