//
//  MainViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class PaymentMethodsViewController: SteptsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.Cell.StepImage, forCellReuseIdentifier: cellIdenIdentifier)

        viewModel = CoordinatorViewModel.shared.paymentsViewModel

        nextButton.setTitle("Select a payment method", for: .disabled)
        nextButton.setTitle("Next", for: .normal)
    }
}
