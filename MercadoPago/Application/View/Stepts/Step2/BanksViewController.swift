//
//  BanksViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BanksViewController: SteptsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.Cell.StepImage, forCellReuseIdentifier: cellIdenIdentifier)

        viewModel = CoordinatorViewModel.shared.banksViewModel

        nextButton.setTitle("Select your bank provider", for: .disabled)
        nextButton.setTitle("Next", for: .normal)
    }
}
