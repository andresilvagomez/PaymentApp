//
//  CoordinatorViewModel.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class CoordinatorViewModel {
    static let shared = CoordinatorViewModel()

    private var api: Api

    private var selectedCard: CreditCard?
    private var selectedBank: Bank?
    private var selectedInstallment: Installment?
    private var amounth: Double = 0

    var selectedViewModel: SelectedPaymentViewModel? {
        guard let selectedCard = selectedCard,
            let selectedBank = selectedBank,
            let selectedInstallment = selectedInstallment else {
            return nil
        }

        return SelectedPaymentViewModel(
            amount: amounth,
            card: selectedCard,
            bank: selectedBank,
            installment: selectedInstallment
        )
    }

    var completed: Bool {
        return  selectedCard != nil &&
                selectedBank != nil &&
                selectedInstallment != nil
    }

    init() {
        self.api = Api()
    }

    func update(amounth: Double) {
        self.amounth = amounth
    }

    func clear() {
        amounth = 0
        selectedCard = nil
        selectedBank = nil
        selectedInstallment = nil
    }
}

/// MARK: Coordination View Models
extension CoordinatorViewModel {
    var paymentsViewModel: CollectionViewModel<CreditCard>! {
        let request = Api.PaymentMethods()
        let viewModel = CollectionViewModel<CreditCard>(api: api, request: request)
        viewModel.selectedHandler = { [weak self] (selected) in
            self?.selectedCard = selected
        }
        return viewModel
    }

    var banksViewModel: CollectionViewModel<Bank> {
        let request = Api.CardIssuers(paymentMethodId: selectedCard?.id)
        let viewModel = CollectionViewModel<Bank>(api: api, request: request)
        viewModel.selectedHandler = { [weak self] (selected) in
            self?.selectedBank = selected
        }
        return viewModel
    }

    var installmentViewModel: CollectionViewModel<Installment> {
        let request = Api.Installments(
            paymentMethodId: selectedCard?.id,
            issuerId: selectedBank?.id,
            amount: amounth
        )
        let viewModel = CollectionViewModel<Installment>(api: api, request: request)
        viewModel.selectedHandler = { [weak self] (selected) in
            self?.selectedInstallment = selected
        }
        return viewModel
    }
}
