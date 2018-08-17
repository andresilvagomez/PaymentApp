//
//  MainViewModel.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate: class {
    func errorFetchingApi(_ error: Error)
    func reloadData()
}

class MainViewModel {
    private var cards = [CreditCard]()

    weak var delegate: MainViewModelDelegate?

    var numberOfItems: Int {
        return cards.count
    }

    init() {
        let request = Api.PaymentMethods()
        Api.request(request) { [weak self] (response) in
            if let error = response as? Error {
                self?.delegate?.errorFetchingApi(error)
                return
            }

            guard let cards = response as? [CreditCard] else {
                return
            }

            self?.cards = cards
            self?.delegate?.reloadData()
        }
    }

    func card(at indexPath: IndexPath) -> CreditCard {
        return cards[indexPath.row]
    }
}
