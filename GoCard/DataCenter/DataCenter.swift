//
//  DataCenter.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/15/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

final class Key {
    enum User: String, CustomStringConvertible {
        case username = "username"
        case lastAccess = "lastAccess"
        case avatarUrl = "avatarUrl"
        case baseCurrency = "baseCurrency"
        var description: String {
            return self.rawValue
        }
    }
    enum Goal: String, CustomStringConvertible {
        case goalId = "goalId"
        case title = "title"
        case detail = "detail"
        case featurePhotoUrl = "featurePhotoUrl"
        case targetCost = "targetCost"
        case savedCost = "savedCost"
        case autoTransfer = "autoTransfer"
        case autoTransgerValue = "autoTransgerValue"
        case frequentcy = "frequentcy"
        var description: String {
            return self.rawValue
        }
    }
    enum Transaction: String, CustomStringConvertible {
        case id = "id"
        case title = "title"
        case detail = "detail"
        case time = "time"
        var description: String {
            return self.rawValue
        }
    }
    enum Wallet: String, CustomStringConvertible {
        case icon  = "icon"
        case unit = "unit"
        case amount = "amount"
        var description: String {
            return self.rawValue
        }
    }
}

extension Realm {
    func save(_ execute:()->Void){
        self.beginWrite()
        execute()
        try! self.commitWrite()
    }
}

final class DataCenter {
    
    struct Rate {
        var unit: String
        var rateValue: Float
    }
    
    static var user:User? {
        didSet{
            print("User: \(String(describing: user?.username))")
        }
    }
    
    static var rates:[String:Float] = [:] {
        didSet{
            let unit = Session.currency
            var unitRates:[Rate] = []
            rates.forEach { (key: String,value: Float) in
                let rate = Rate(unit: key, rateValue: value)
                unitRates.append(rate)
            }
            let rate = Rate(unit: unit, rateValue: 1.0)
            unitRates.append(rate)
            rateLog[unit] = unitRates
        }
    }
    
    static var rateLog:[String:[Rate]] = [:]
    
    class func generateDemo() {
        Goal.generateDemoData()
        Transaction.generateDemoData()
        Wallet.generateDemoData()
        
        let currenciesUnit = ["SGD", "THB", "JPY", "USD"]
        currenciesUnit.forEach { unit in
            DataCenter.fetchExchangeRate(unit, completion: { (data:JSON) in
                print("Loaded \(unit)")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"ratesDidUpdated"), object: nil)
            }, failed: nil)
        }
    }
    
    
}

// Currency convert
extension DataCenter {
    class func refreshEx(onCompleted completed:@escaping ([Rate])->()) {
        let unit = Session.currency
        if let unitRate = DataCenter.rateLog[unit] {
            if unitRate.count > 0 {
                print("--\(unitRate)\n--Had already")
                completed(unitRate)
                return
            }
        }
        fetchExchangeRate(unit, completion: { (data:JSON) in
            guard let unitRates = DataCenter.rateLog[unit] else { return }
            completed(unitRates)
        }, failed: nil)
    }
    
    class func fetchExchangeRate(_ baseCurrencyCode: String, completion: ((JSON) -> Void)!, failed:((Error?) -> Void)!) {
        if DataCenter.ratesFor(base: baseCurrencyCode).count > 0 {
            completion(JSON(parseJSON:"{}"))
            return
        }
        Alamofire.request("http://api.fixer.io/latest?base=\(baseCurrencyCode)").responseJSON { response in
            if response.result.isSuccess {
                let jsonObject = JSON(data: response.data!)
                if let rate = jsonObject["rates"].dictionaryObject as? [String:Float] {
                    DataCenter.rates = rate
                }
                completion?(jsonObject)
            } else {
                failed?(response.result.error)
            }
        }
    }
    
    class func rate(currency:String) -> Float {
        let rate = DataCenter.rates[currency] ?? 0.0
        print("\(Session.currency)-\(currency):\(rate)")
        return rate
    }
    class func ratesFor( base:String) -> [DataCenter.Rate] {
        return DataCenter.rateLog[base] ?? []
    }
    
    class func convert( from fromUnit: String, to toUnit: String, amount value:Float) -> Float{
        let rates = DataCenter.ratesFor(base: fromUnit)
        var convertedValue = value
        rates.forEach {
            if $0.unit == toUnit {
                convertedValue = convertedValue * $0.rateValue
            }
        }
        return convertedValue
    }
}
