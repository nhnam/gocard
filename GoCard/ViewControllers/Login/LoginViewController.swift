//
//  LoginViewController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/13/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: BaseViewController {

    @IBOutlet weak var buttonFacebook: UIButton!
    @IBOutlet weak var buttonGoogle: UIButton!
    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet var lines: [Line]!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    private func setup(){
        lines.forEach {
            $0.backgroundColor = UIColor.clear
            $0.lineColor = UIColor.white.withAlphaComponent(0.48)
            $0.setNeedsDisplay()
        }
        [buttonSignIn, buttonFacebook, buttonGoogle].forEach {
            $0?.round()
            $0?.characterSpacing(1.82, lineHeight: 14, withFont: UIFont.boldOpenSans(size:10))
            $0?.layer.shadowRadius = 5.0
            $0?.layer.shadowOpacity = 0.55
            $0?.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        [usernameLabel,passwordLabel].forEach {
            $0?.textColor = UIColor.white.withAlphaComponent(0.5)
            $0?.characterSpacing(0.82, lineHeight: 11, withFont: UIFont(name: "Helvetica Neue", size: 9) ?? UIFont.systemFont(ofSize: 9))
        }
        orLabel.characterSpacing(1.82, lineHeight: 14, withFont: UIFont.boldOpenSans(size:10))
        
        [usernameField, passwordField].forEach {
            $0?.contentVerticalAlignment = .center
            $0?.characterSpacing(1.75)
        }
        
        usernameField.attributedPlaceholder = NSAttributedString(string: "Your username", attributes: [NSFontAttributeName: UIFont.openSans(size: 14), NSForegroundColorAttributeName: UIColor.white])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Your password", attributes: [NSFontAttributeName: UIFont.openSans(size: 14), NSForegroundColorAttributeName: UIColor.white])
        passwordField.isSecureTextEntry = true
        let registerTitle = NSAttributedString(string: "Register Now", attributes: [NSForegroundColorAttributeName: UIColor.white, NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSFontAttributeName: UIFont.boldOpenSans(size: 10)])
        
        buttonFacebook.backgroundColor = UIColor(hex:0x5072BA)
        buttonFacebook.centerButtonAndImageWithSpacing(25)
        buttonGoogle.centerButtonAndImageWithSpacing(25)
        buttonGoogle.backgroundColor = UIColor.white
        
        buttonSignIn.layer.shadowColor = UIColor(hex:0x3578A4).cgColor
        buttonSignIn.setNeedsDisplay()
        buttonFacebook.layer.shadowColor = UIColor(hex:0x224287).cgColor
        buttonFacebook.setNeedsDisplay()
        buttonGoogle.layer.shadowColor = UIColor(hex:0x224287).cgColor
        buttonGoogle.setNeedsDisplay()
        
        registerbutton.setAttributedTitle(registerTitle, for: .normal)
        registerbutton.setAttributedTitle(registerTitle, for: .selected)
        
        // load previous user
        let realm = try! Realm()
        if let user = realm.objects(User.self).sorted(byKeyPath: Key.User.lastAccess.rawValue).first {
            usernameField.text = user.username
            usernameField.characterSpacing(1.75)
        }
    }

    @IBAction func didTouchSignIn(_ sender: Any) {
        signinSuccessful()
        buttonSignIn.peek()
    }
    
    @IBAction func didTouchLoginFacebookButton(_ sender: Any) {
        signinSuccessful()
        buttonFacebook.peek()
    }
    
    @IBAction func didTouchGoogle(_ sender: Any) {
        signinSuccessful()
        buttonGoogle.peek()
    }
    
    @IBAction func didTouchRegisterButton(_ sender: Any) {
        signinSuccessful()
    }
    
    private func signinSuccessful() {
        let realm = try! Realm()
        realm.save {
            let username = usernameField.text!
            realm.create(User.self, value: [Key.User.username.rawValue: username, Key.User.lastAccess.rawValue: Date(), Key.User.baseCurrency: "SGD"], update:true)
            if let user = realm.objects(User.self).sorted(byKeyPath: Key.User.lastAccess.rawValue).first {
                DataCenter.user = user
            }
        }
        UserDefaults.standard.set(true, forKey: "authed")
        
        self.showWaiting()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.hideWaiting()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
