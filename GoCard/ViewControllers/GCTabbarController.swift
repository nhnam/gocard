//
//  GCTabbarController.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/12/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit

final class GCTabbarController: UITabBarController {
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        self.setupAppearance()
        return super.awakeAfter(using: aDecoder)
    }
    
    private func setupAppearance(){
        self.tabBar.tintColor = UIColor.tabBarTint
        self.tabBar.unselectedItemTintColor = UIColor.tabBarUnselectedTint
        UITabBar.appearance().shadowImage = #imageLiteral(resourceName: "Tabbar Shadow")
        UITabBar.appearance().backgroundImage = UIImage()
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name(rawValue:"appDidLogout"), object: nil)
        self.selectedIndex = 2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoginIfNeed()
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - 60
        self.tabBar.frame = tabFrame
    }
    
    private func showLoginIfNeed() {
        if !UserDefaults.standard.bool(forKey: "authed"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewcontroller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    @objc func logout() {
        self.selectedIndex = 2
        UserDefaults.standard.set(false, forKey: "authed")
        self.showLoginIfNeed()
    }
}
