//
//  StepsViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        disableNextButton()
    }

    func disableNextButton() {
        nextButton.isEnabled = false
        nextButton.backgroundColor = UIColor.buttonDisabled
        nextView.backgroundColor = UIColor.buttonDisabled

    }

    func enableNextButton() {
        nextButton.isEnabled = true
        nextButton.backgroundColor = UIColor.buttonEnabled
        nextView.backgroundColor = UIColor.buttonEnabled
    }
}
