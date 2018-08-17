//
//  ViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import BRYXBanner

extension UIViewController {

    func banner(error: Error) {
        let message = error.message
        Banner(
            title: "Error",
            subtitle: message,
            image: nil,
            backgroundColor: UIColor.appRed,
            didTapBlock: nil
        ).show()
    }

}
