//
//  MainViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class MainViewController: NextViewController {
    @IBOutlet weak var amonthTextField: UITextField!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    @IBOutlet weak var completionView: UIView!

    @IBOutlet weak var amonthLabel: UILabel!
    @IBOutlet weak var franchiseLabel: UILabel!
    @IBOutlet weak var franchiseImage: UIImageView!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var duesLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    private var viewModel = CoordinatorViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        amonthTextField.delegate = self

        let selector = #selector(MainViewController.keyboardWillShow)
        let name = Notification.Name.UIKeyboardWillShow
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            bottomLayout.constant = keyboardSize.height * -1
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        completionView.isHidden = !viewModel.completed

        if viewModel.completed {
            setUpPaymentDetails()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.completed {
            completionView.isHidden = false
            nextButton.setTitle("Pay", for: .normal)
            bottomLayout.constant = 0
            amonthTextField.resignFirstResponder()
        } else {
            completionView.isHidden = true
            nextButton.setTitle("Enter your amounth", for: .disabled)
            nextButton.setTitle("Next", for: .normal)
            amonthTextField.becomeFirstResponder()
        }
    }

    func setUpPaymentDetails() {
        guard let viewModel = viewModel.selectedViewModel else { return }

        amonthLabel.text = viewModel.amount
        franchiseLabel.text = viewModel.cardName
        franchiseImage.setImage(string: viewModel.cardImageUrl)
        bankLabel.text = viewModel.bankName
        bankImage.setImage(string: viewModel.bankImageUrl)
        duesLabel.text = viewModel.duesPayment
        totalLabel.text = viewModel.totalPayment
    }

    func showThanksAlert() {
        let alert = UIAlertController(
            title: "Thanks",
            message: "We aprecitate your payment, Enjoy your product",
            preferredStyle: .alert
        )
        let acction = UIAlertAction(title: "Ok", style: .default) { [weak self] (_) in
            guard let `self` = self else { return }

            self.amonthTextField.text = nil
            self.viewModel.clear()
            self.viewWillAppear(true)
            self.viewDidAppear(true)
        }
        alert.addAction(acction)
        present(alert, animated: true, completion: nil)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if viewModel.completed {
            showThanksAlert()
            return false
        }

        return true
    }
}

extension MainViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let text = textField.text else { return }
            guard let amount = Double(text) else { return }
            self?.viewModel.update(amounth: amount)
            self?.enableNextButton()
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        view.endEditing(true)
        return true
    }
}
