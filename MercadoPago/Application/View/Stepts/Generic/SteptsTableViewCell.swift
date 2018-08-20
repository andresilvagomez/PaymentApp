//
//  SteptsTableViewCell.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/20/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class SteptsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var itemImage: UIImageView?
    @IBOutlet weak var detailLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(with viewModel: CollectionItemViewModel) {
        nameLabel.text = viewModel.title
        detailLabel?.text = viewModel.subtitle
        itemImage?.setImage(string: viewModel.url, placeholderImage: #imageLiteral(resourceName: "CreditCard"))
    }
}
