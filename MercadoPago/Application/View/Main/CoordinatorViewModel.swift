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

    private let paymentsViewModel: MainViewModel
    private var banksViewModel: BanksViewModel!

    init() {
        self.api = Api()

        self.paymentsViewModel = MainViewModel(api: api)
    }

    func getPaymentsViewModel() -> MainViewModel {
        return paymentsViewModel
    }

    func getBanksViewModel() -> BanksViewModel {
        if banksViewModel == nil {
            banksViewModel = BanksViewModel(
                api: api,
                selected: paymentsViewModel.selectedCard
            )
        }
        return banksViewModel
    }
}
