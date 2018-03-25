//
//  DropdownListview.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/15/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

struct Account{
    var name:String
    var avatar:String
}

protocol DropdownListviewDelegate{
    func dropDownDidShow(_ dropdown:DropdownListview) -> Void
    func dropDownTextChanged(_ text:String?) -> Void
    func dropDownDidPick(_ account:Account) -> Void
    func dropDownWillHide(_ dropdown:DropdownListview) -> Void
}

final class DropdownListview: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var userIcon:UIImageView!
    @IBOutlet weak var dropdownButton:UIButton!
    @IBOutlet weak var filterTextfield:UITextField!
    var delegate:DropdownListviewDelegate?
    private var accounts:[Account] = []
    private var selectedAccounts:[Account] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.round(10)
        tableView.keyboardDismissMode = .onDrag
        filterTextfield.characterSpacing(1.65)
        filterTextfield.font = UIFont.roboto(size:13)
        filterTextfield.textColor = UIColor.textDefault
        filterTextfield.delegate = self
        filterTextfield.addTarget(self, action: #selector(filterDidChanged(_:)), for: .editingChanged)
        self.clipsToBounds = true
        initDemoAccounts()
    }
    
    private func initDemoAccounts() {
        for _ in 0..<10 {
            accounts.append(Account(name: Randoms.randomFakeName(), avatar: ""))
        }
    }
    
    class func instance() -> DropdownListview {
        let dropdown = Bundle.main.loadNibNamed("DropdownListview", owner: self, options: nil)?.first! as! DropdownListview
        dropdown.round(10)
        dropdown.decorate()
        return dropdown
    }
    
    @objc func filterDidChanged(_ sender: UITextField) {
        sender.characterSpacing(1.65)
        delegate?.dropDownTextChanged(sender.text)
        if (sender.text?.count ?? 0) >= 2 {
            selectedAccounts.removeAll()
            var accCopied:[Account] = []
            accCopied.append(contentsOf: accounts)
            let filterred = accCopied.filter {
                return $0.name.hasPrefix(sender.text!)
            }
            selectedAccounts.append(contentsOf: filterred)
        } else {
            selectedAccounts.removeAll()
        }
        tableView.reloadData()
    }
    
    private func isFilterred() -> Bool {
        return (filterTextfield.text?.count ?? 0) >= 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isFilterred() ? selectedAccounts.count : accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell_id")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell_id")
        }
        config(cell!, index: indexPath.row)
        return cell!
    }
    
    private func config(_ cell:UITableViewCell, index idx: Int) {
        let acc  = isFilterred() ? selectedAccounts[idx] : accounts[idx]
        cell.textLabel?.text = acc.name
        cell.textLabel?.textColor = UIColor.textDefault
        cell.textLabel?.characterSpacing(1.65, lineHeight: 15, withFont: UIFont.roboto(size:13))
        cell.imageView?.round()
        let image = #imageLiteral(resourceName: "User Placeholder Icon")
        cell.imageView?.image = image
        cell.imageView?.transform = CGAffineTransform(scaleX: 40.0/image.size.width, y: 40.0/image.size.height);
        cell.backgroundColor = UIColor(hex:0xF3F3F3)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idx = indexPath.row
        let acc  = isFilterred() ? selectedAccounts[idx] : accounts[idx]
        delegate?.dropDownDidPick(acc)
        hide()
    }
    
    @IBAction func didTouchDropdownButton(_ sender: Any) {
        hide()
    }
}

extension DropdownListview {
    internal func show(withTarget view:UIView, inView superView:UIView) {
        superView.addSubview(self)
        let frame = view.frame
        let frameState0 = CGRect(x: frame.origin.x - 10, y: frame.origin.y - 10, width: frame.size.width + 20, height: 40)
        let frameState1 = CGRect(x: frame.origin.x - 10, y: frame.origin.y - 10, width: frame.size.width + 20, height: 250)
        self.frame = frameState0
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.35) {
            self.frame = frameState1
            self.setNeedsLayout()
        }
        delegate?.dropDownDidShow(self)
    }
    internal func hide(){
        delegate?.dropDownWillHide(self)
        self.removeFromSuperview()
    }
}
