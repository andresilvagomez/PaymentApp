//
//  MainViewController.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class MainViewController: NextViewController {
    private var viewModel = CoordinatorViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enableNextButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.completed {
            
        } else {
            
        }
    }
}
