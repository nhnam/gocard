//
//  Goal.swift
//  GoCard
//
//  Created by ナム Nam Nguyen on 3/23/17.
//  Copyright © 2017 GoCard, Ltd. All rights reserved.
//

import Foundation
import RealmSwift

final class Goal: Object {
    @objc enum Frequentcy:Int {
        case none = 0
        case daily = 1
        case weekly = 2
        case monthly = 3
    }
    dynamic var goalId:Int = 0
    dynamic var title = ""
    dynamic var detail = ""
    dynamic var featurePhotoUrl = ""
    dynamic var targetCost:Float = 0.0
    dynamic var savedCost:Float = 0.0
    dynamic var autoTransfer:Bool = false
    dynamic var autoTransgerValue:Float = 0.0
    dynamic var frequentcy:Frequentcy = .none
    override class func primaryKey() -> String? {
        return Key.Goal.goalId.rawValue
    }
    
    class func generateDemoData() {
        let realm = try! Realm()
        realm.save {
            realm.create(Goal.self, value: [Key.Goal.goalId.rawValue: 1,
                                            Key.Goal.title.rawValue:"Kyoto - Japan",
                                            Key.Goal.detail.rawValue:"The shrines and temples of Kyoto offer a rare link between modern life in the city and its very ancient past. The Shimogamo Shrine dates to the 6th century and seems suspended in time, its serenity and spiritual power still palpable. Visit Fushimi Inari Shrine, then see the life-sized Thousand Armed Kannon statues of Sanjūsangen-dō. Enjoy traditional geisha performances, then savor a tranquil meal at a restaurant overlooking the Kamo River.",
                                            Key.Goal.featurePhotoUrl.rawValue:"https://media-cdn.tripadvisor.com/media/photo-s/03/9b/2d/dc/kyoto.jpg"], update:true)
            realm.create(Goal.self, value: [Key.Goal.goalId.rawValue: 2,
                                            Key.Goal.title.rawValue:"Osaka - Japan",
                                            Key.Goal.detail.rawValue:"Home to nearly nine million and powering an economy that exceeds both Hong Kong's and Thailand's, Osaka packs quite a punch. The confident, stylish city is a shopping hub, with fabulous restaurants and nightlife. It's an ideal base for exploring the Kansai region; Kyoto's World Heritage Sites, Nara's temple and Koya-san's eerie graves are within 90 minutes by train. Top city attractions include the aquarium, Osaka Castle, Universal Studios Japan and the futuristic Floating Garden Observatory.",
                                            Key.Goal.featurePhotoUrl.rawValue:"https://media-cdn.tripadvisor.com/media/photo-s/01/31/a2/3b/osaka-castle-seen-from.jpg"], update:true)
            realm.create(Goal.self, value: [Key.Goal.goalId.rawValue: 3,
                                            Key.Goal.title.rawValue:"Seoul - South Korea",
                                            Key.Goal.detail.rawValue:"Seoul is the business and cultural hub of South Korea, where skyscrapers tower over Buddhist temples. Take it all in from the N Seoul Tower, built atop a peak in Namsan Park. The teahouses and shops of Insadong give you a taste of Korean flavor, which you can further experience with a visit to the grounds and museums of Gyeongbokgung. UNESCO World Heritage Site Changdeokgung Palace is a fine example of authentic ancient architecture.",
                                            Key.Goal.featurePhotoUrl.rawValue:"https://media-cdn.tripadvisor.com/media/photo-s/03/9b/2e/0e/seoul.jpg"], update:true)
        }
    }
}
