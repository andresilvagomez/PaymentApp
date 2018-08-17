//
//  MainViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class PaymentMethodsViewController: NextViewController {
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: CollectionViewModel<CreditCard>!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CoordinatorViewModel.shared.paymentsViewModel
        viewModel.delegate = self
        viewModel.requestApi()

        nextButton.setTitle("Select a payment method", for: .disabled)
        nextButton.setTitle("Next", for: .normal)
    }
}

extension PaymentMethodsViewController: CollectionViewModelDelegate {
    func startLoadingApi() {

    }

    func endLoadingApi() {

    }

    func errorFetchingApi(_ error: Error) {

    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension PaymentMethodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(at: indexPath)
        enableNextButton()
    }
}

extension PaymentMethodsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CreditCardCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? CreditCardTableViewCell
        cell?.setUp(with: viewModel.item(at: indexPath))
        cell?.accessoryType = viewModel.isSelected(at: indexPath) ? .checkmark : .none
        return cell ?? UITableViewCell()
    }
}
