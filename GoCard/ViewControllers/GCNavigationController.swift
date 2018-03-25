//
//  GCNavigationController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class GCNavigationController: UINavigationController {
    private var titleLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleAttributed()
    }
    
    class func setupTransparent(){
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font:UIFont.navigationBarTitle, NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.kern: Float(2.0)]
    }
    
    func setupTitleAttributed() {
        let backImage = #imageLiteral(resourceName: "Back Icon")
        self.navigationBar.backIndicatorImage = backImage
        self.navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        print("-> \(viewController.classForCoder)")
    }
}
