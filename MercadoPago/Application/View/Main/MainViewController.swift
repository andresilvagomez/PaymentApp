//
//  MainViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
    }
}

extension MainViewController: MainViewModelDelegate {
    func errorFetchingApi(_ error: Error) {

    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CreditCardCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            as? CreditCardTableViewCell

        let card = viewModel.card(at: indexPath)
        cell?.setUp(with: card)

        return cell ?? UITableViewCell()
    }
}
