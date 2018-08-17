//
//  Mapper.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/16/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONMapper {
    init(json: JSON)
}

extension JSON {
    func mapArray<T: JSONMapper>() -> [T] {
        guard let array = array else {
            print("You don't have elements to map")
            return []
        }

        var models = [T]()

        for item in array {
            let model = T(json: item)
            models.append(model)
        }

        return models
    }

    func map<T: JSONMapper>() -> T {
        return T(json: self)
    }
}
