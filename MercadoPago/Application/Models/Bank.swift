//
//  Bank.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/16/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Bank: JSONMapper {
    var id: Int
    var name: String
    var secureThumbnail: String
    var thumbnail: String
    var processingMode: String
    var merchantAccountId: String

    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.secureThumbnail = json["secure_thumbnail"].stringValue
        self.thumbnail = json["thumbnail"].stringValue
        self.processingMode = json["processing_mode"].stringValue
        self.merchantAccountId = json["merchant_account_id"].stringValue
    }
}

extension Bank: Equatable {
    static func == (lhs: Bank, rhs: Bank) -> Bool {
        return lhs.id == rhs.id
    }
}
