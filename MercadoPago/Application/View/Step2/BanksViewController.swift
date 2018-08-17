//
//  BanksViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BanksViewController: NextViewController {
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: CollectionViewModel<Bank>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.emptyDataSetSource = self

        viewModel = CoordinatorViewModel.shared.banksViewModel
        viewModel.delegate = self
        viewModel.requestApi()

        nextButton.setTitle("Select your bank provider", for: .disabled)
        nextButton.setTitle("Next", for: .normal)
    }
}

extension BanksViewController: CollectionViewModelDelegate {
    func errorFetchingApi(_ error: Error) {
        banner(error: error)
    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension BanksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(at: indexPath)
        enableNextButton()
    }
}

extension BanksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "BankCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BankTableViewCell
        cell?.setUp(with: viewModel.item(at: indexPath))
        cell?.accessoryType = viewModel.isSelected(at: indexPath) ? .checkmark : .none
        return cell ?? UITableViewCell()
    }
}

extension BanksViewController: DZNEmptyDataSetSource {
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }
}
