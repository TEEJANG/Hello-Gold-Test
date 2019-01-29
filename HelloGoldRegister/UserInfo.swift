//
//  UserInfo.swift
//  HelloGoldRegister
//
//  Created by Teerawat on 26/1/2562 BE.
//  Copyright © 2562 Teerawat. All rights reserved.
//

import Foundation
import UIKit

class UserInfo {
    var email: String
    var uuid: Int
    var data: String
    var tnc: Bool
    init(email: String = "", uuid: Int = Int.random(in: 0 ... 10000000000), data: String = "", tnc: Bool = true) {
        self.email = email
        self.uuid = uuid
        self.data = data
        self.tnc = tnc
    }
    
    public struct helloGoldToday : Codable {
        var buy: Double
        var sell: Double
        var spotPrice: Double
//        var timeStamp: Date
        init(_ dictionary: [String: Any]) {
            self.buy = dictionary["buy"] as? Double ?? 0
            self.sell = dictionary["sell"] as? Double ?? 0
            self.spotPrice = dictionary["spotPrice"] as? Double ?? 0
//            self.timeStamp = dictionary["timeStamp"] as? Date ?? 2019-01-26:07:44.719+00:00
        }
    }
}
