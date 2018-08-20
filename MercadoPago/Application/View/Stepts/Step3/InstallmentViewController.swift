//
//  InstallmentViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class InstallmentViewController: SteptsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.Cell.SubTitle, forCellReuseIdentifier: cellIdenIdentifier)

        viewModel = CoordinatorViewModel.shared.installmentViewModel

        nextButton.setTitle("Select your number of dues", for: .disabled)
        nextButton.setTitle("Next", for: .normal)
    }

    @IBAction func goToHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
