//
//  Error.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/17/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit

extension NSError {
    static let emptyData = NSError(message: "The provider data is empty, we can't show results")
}

extension Error {
    var message: String {
        let error = self as NSError

        guard let message = error.userInfo["message"] as? String else {
            return localizedDescription
        }

        return message
    }

    static func with(message: String, code: Int = -1) -> Error {
        return NSError(domain: "", code: code, userInfo: [
            "message": message
        ])
    }
}

extension NSError {
    convenience init(message: String, code: Int = -1) {
        self.init(domain: "", code: code, userInfo: [
            "message": message
        ])
    }
}
