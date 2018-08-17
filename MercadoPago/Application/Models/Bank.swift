//
//  Bank.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/16/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

struct Bank: Codable {
    var id: String
    var name: String
    var secureThumbnail: String
    var thumbnail: String
    var processingMode: String
    var merchantAccountId: String
}
