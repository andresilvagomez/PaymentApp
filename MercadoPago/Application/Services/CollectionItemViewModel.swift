//
//  CollectionItemViewModel.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/20/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation

class CollectionItemViewModel {
    var title: String?
    var subtitle: String?
    var url: String?

    init(model: Any) {
        if let bank = model as? Bank {
            title = bank.name
            url = bank.thumbnail
        }

        if let installment = model as? Installment {
            title = installment.customMessage
            subtitle = installment.total
        }

        if let card = model as? CreditCard {
            title = card.name
            url = card.thumbnail
        }
    }
}
