//
//  BanksViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class BanksViewController: StepsViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.setTitle("Select your bank provider", for: .disabled)
        nextButton.setTitle("Next", for: .normal)
    }
}

extension BanksViewController: UITableViewDelegate {

}

extension BanksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "BankCell"
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}
