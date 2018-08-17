//
//  BanksViewModel.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class BanksViewModel {
    private var api: Api
    private var selectedCard: CreditCard

    init(api: Api, selected card: CreditCard) {
        self.api = api
        self.selectedCard = card
    }

    func request() {
        let request = Api.CardIssuers(paymentMethodId: selectedCard.id)
        api.request(request) { (_) in

        }
    }
}
