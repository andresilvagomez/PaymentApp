//
//  CreditCardTableViewCell.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

class CreditCardTableViewCell: UITableViewCell {
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(with card: CreditCard) {
        cardImage.setImage(string: card.secureThumbnail)
        cardNameLabel.text = card.name
    }
}
