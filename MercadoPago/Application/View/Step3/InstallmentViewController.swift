//
//  InstallmentViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class InstallmentViewController: NextViewController {
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: CollectionViewModel<Installment>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.emptyDataSetSource = self

        viewModel = CoordinatorViewModel.shared.installmentViewModel
        viewModel.delegate = self
        viewModel.requestApi()

        nextButton.setTitle("Select your number of dues", for: .disabled)
        nextButton.setTitle("Next", for: .normal)
    }

    @IBAction func goToHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension InstallmentViewController: CollectionViewModelDelegate {
    func errorFetchingApi(_ error: Error) {
        banner(error: error)
    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension InstallmentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(at: indexPath)
        enableNextButton()
    }
}

extension InstallmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let installment = viewModel.item(at: indexPath)
        cell.textLabel?.text = installment.customMessage
        cell.detailTextLabel?.text = installment.total
        cell.accessoryType = viewModel.isSelected(at: indexPath) ? .checkmark : .none
        return cell
    }
}

extension InstallmentViewController: DZNEmptyDataSetSource {
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }
}
