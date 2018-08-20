//
//  SelectedPaymentViewModel.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/20/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class SelectedPaymentViewModel {
    var amount: String
    var cardName: String
    var cardImageUrl: String
    var bankName: String
    var bankImageUrl: String
    var duesPayment: String
    var totalPayment: String

    init(
        amount: Double,
        card: CreditCard,
        bank: Bank,
        installment: Installment) {

        self.amount = "Total: $\(amount)"
        self.cardName = card.name
        self.cardImageUrl = card.thumbnail
        self.bankName = bank.name
        self.bankImageUrl = bank.thumbnail
        self.duesPayment = installment.customMessage
        self.totalPayment = installment.total
    }
}
