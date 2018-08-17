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
    private var api: Api

    weak var delegate: MainViewModelDelegate?

    var selectedCard: CreditCard {
        return cards.first(where: { $0.isSelected == true })!
    }

    var numberOfItems: Int {
        return cards.count
    }

    init(api: Api) {
        self.api = api
    }

    func request() {
        let request = Api.PaymentMethods()
        api.request(request) { [weak self] (response) in
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

    func select(at indexPath: IndexPath) {
        cards.forEach({ $0.isSelected = false })
        cards[indexPath.row].isSelected = true
        delegate?.reloadData()
    }

    func card(at indexPath: IndexPath) -> CreditCard {
        return cards[indexPath.row]
    }
}
