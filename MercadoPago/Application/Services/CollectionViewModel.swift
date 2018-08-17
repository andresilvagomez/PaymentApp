//
//  CollectionViewModel.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation

protocol CollectionViewModelDelegate: class {
    func errorFetchingApi(_ error: Error)
    func reloadData()
}

class CollectionViewModel<T: Equatable> {
    private var items = [T]()
    private var selectedItem: T? {
        didSet {
            selectedHandler?(selectedItem)
        }
    }
    private var request: ApiRequestProtocol
    private var api: Api

    weak var delegate: CollectionViewModelDelegate?
    var selectedHandler: ( (_ selected: T?) -> Void )?

    var numberOfItems: Int {
        return items.count
    }

    init(api: Api, request: ApiRequestProtocol) {
        self.api = api
        self.request = request
    }

    func requestApi() {
        api.request(request) { [weak self] (response) in
            if let error = response as? Error {
                self?.delegate?.errorFetchingApi(error)
                return
            }

            guard let items = response as? [T] else {
                return
            }

            self?.items = items
            self?.delegate?.reloadData()
        }
    }

    func isSelected(at indexPath: IndexPath) -> Bool {
        let index = items.index(where: { $0 == selectedItem })
        return indexPath.row == index
    }

    func select(at indexPath: IndexPath) {
        selectedItem = item(at: indexPath)
        delegate?.reloadData()
    }

    func item(at indexPath: IndexPath) -> T {
        return items[indexPath.row]
    }

    func selected() -> T? {
        return selectedItem
    }
}
