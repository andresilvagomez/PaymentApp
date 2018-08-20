//
//  SteptsViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/20/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SteptsViewController: NextViewController {
    @IBOutlet weak var tableView: UITableView!

    var cellIdenIdentifier = "Cell"
    var viewModel: CollectionViewModelInterface! {
        didSet {
            viewModel.delegate = self
            viewModel.requestApi()
        }
    }

    override func viewDidLoad() {
        tableView.emptyDataSetSource = self
        tableView.delegate = self
        tableView.dataSource = self

        super.viewDidLoad()
    }
}

extension SteptsViewController: CollectionViewModelDelegate {
    func errorFetchingApi(_ error: Error) {
        banner(error: error)
    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension SteptsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(at: indexPath)
        enableNextButton()
    }
}

extension SteptsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdenIdentifier, for: indexPath)
            as? SteptsTableViewCell
        let item = viewModel.item(at: indexPath)
        cell?.setUp(with: item)
        cell?.accessoryType = viewModel.isSelected(at: indexPath) ? .checkmark : .none
        return cell ?? UITableViewCell()
    }
}

extension SteptsViewController: DZNEmptyDataSetSource {
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }
}
