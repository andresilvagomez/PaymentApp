//
//  Payment.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Installment: JSONMapper {
    var installments: Int
    var recommendedMessage: String
    var installmentRate: Double
    var discountRate: Double
    var installmentAmount: Double
    var totalAmount: Double

    var customMessage: String {
        return "\(installments) dues with $\(installmentAmount)"
    }
    var total: String {
        return "total: $ \(totalAmount)"
    }

    init(json: JSON) {
        self.installments = json["installments"].intValue
        self.recommendedMessage = json["recommended_message"].stringValue
        self.installmentRate = json["installment_rate"].doubleValue
        self.discountRate = json["discount_rate"].doubleValue
        self.installmentAmount = json["installment_amount"].doubleValue
        self.totalAmount = json["total_amount"].doubleValue
    }
}

extension Installment: Equatable {
    static func == (lhs: Installment, rhs: Installment) -> Bool {
        return lhs.installments == rhs.installments
    }
}
