//
//  UIViewController+Ext.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/21/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

extension UIViewController{
    class func topViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    func showWaiting( _ dimBackground: Bool = true) {
        let size = CGSize(width: 40, height: 30)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size: size, type: .ballBeat))
    }
    
    func hideWaiting() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
}
