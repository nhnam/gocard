//
//  AppDelegate.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/9/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import SwiftyJSON

@UIApplicationMain
class GoCardAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        setupInitializeSetting()
        setupFakeData()
        // setupAWS()
        Fabric.with([Crashlytics.self])
        return true
    }
    private func setupAppearance(){
        GCNavigationController.setupTransparent()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    private func setupInitializeSetting(){
        UserDefaults.standard.set(false, forKey: "authed")
    }
    
    private func setupFakeData() {
        DataCenter.generateDemo()
        DataCenter.fetchExchangeRate("SGD", completion: { (data:JSON) in
        }, failed: nil)
    }
    
    private func setupAWS() {
//        AWSLogger.default().logLevel = .error
//        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .USEast2, identityPoolId: "us-west-2:6acf2c55-4dd9-4482-9b44-9c5171ba2f6a")
//        let configuration = AWSServiceConfiguration(region:.USEast2, credentialsProvider:credentialProvider)
//        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        // Store the completion handler.
//        AWSS3TransferUtility.interceptApplication(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
    }
}

