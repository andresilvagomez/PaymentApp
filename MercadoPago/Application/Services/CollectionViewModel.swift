//
//  CollectionViewModel.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation

typealias CollectionModel = JSONMapper & Equatable

protocol CollectionViewModelDelegate: class {
    func errorFetchingApi(_ error: Error)
    func reloadData()
}

protocol CollectionViewModelInterface: class {
    var numberOfItems: Int { get }
    var delegate: CollectionViewModelDelegate? { get set }

    func requestApi()
    func isSelected(at indexPath: IndexPath) -> Bool
    func select(at indexPath: IndexPath)
    func item(at indexPath: IndexPath) -> CollectionItemViewModel
    func selected() -> CollectionItemViewModel?
}

class CollectionViewModel<T: CollectionModel>: CollectionViewModelInterface {
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
        api.request(request) { (response) in
            if let error = response as? Error {
                self.delegate?.errorFetchingApi(error)
                return
            }

            guard let items = response as? [T] else {
                return
            }

            self.items = items
            self.delegate?.reloadData()
        }
    }

    func isSelected(at indexPath: IndexPath) -> Bool {
        let index = items.index(where: { $0 == selectedItem })
        return indexPath.row == index
    }

    func select(at indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
        delegate?.reloadData()
    }

    func item(at indexPath: IndexPath) -> CollectionItemViewModel {
        let item = items[indexPath.row]
        return CollectionItemViewModel(model: item)
    }

    func selected() -> CollectionItemViewModel? {
        guard let selectedItem = selectedItem else {
            return nil
        }
        return CollectionItemViewModel(model: selectedItem)
    }
}
