//
//  CreditCard.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/16/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation
import SwiftyJSON

enum CreditCardType: String {
    case none = "none"
    case creditCard = "credit_card"
    case debitCard = "debit_card"
    case ticket = "ticket"
}

class CreditCard: JSONMapper {
    var id: String
    var name: String
    var paymentTypeId: CreditCardType
    var status: Bool
    var secureThumbnail: String
    var thumbnail: String
    var minAllowedAmount: Double
    var maxAllowedAmount: Double

    var isSelected: Bool = false

    required init(json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.paymentTypeId = CreditCardType(
            rawValue: json["payment_type_id"].stringValue
        ) ?? .none
        self.status = json["status"].stringValue == "active"
        self.secureThumbnail = json["secure_thumbnail"].stringValue
        self.thumbnail = json["thumbnail"].stringValue

        self.minAllowedAmount = json["min_allowed_amount"].doubleValue
        self.maxAllowedAmount = json["max_allowed_amount"].doubleValue
    }
}
