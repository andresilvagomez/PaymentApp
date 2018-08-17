//
//  UIImage.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(string: String?, placeholderImage placeholder: UIImage? = nil) {
        guard let url = URL(string: string ?? "") else {
            return
        }

        kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil) { (_, error, _, _) in
            if let error = error {
                print("Error downloading image:", error.localizedDescription)
            }
        }
    }
}
