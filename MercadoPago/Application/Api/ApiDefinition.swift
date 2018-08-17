//
//  ApiDefinitio.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/16/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import Foundation
import SwiftyJSON

private let apiKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
private let baseUrl = "https://api.mercadopago.com/v1/"

extension Api {
    class PaymentMethods: ApiRequestProtocol {
        var method: HttpMethods = .get
        var url: String = baseUrl + "payment_methods"
        var headers: [String: String]? = [:]
        var parameters: [String: Any]? = ["public_key": apiKey]

        func parser(_ error: Error?, _ data: JSON?, _ code: Int?, _ handler: ApiHandler?) {
            if let error = error {
                handler?(error)
                return
            }

            guard let data = data else { return }
            var creditCards = data.mapArray() as [CreditCard]
            creditCards = creditCards.filter({ $0.paymentTypeId == .creditCard && $0.status })

            if creditCards.count == 0 {
                handler?(NSError.emptyData)
                return
            }

            handler?(creditCards)
        }
    }

    class CardIssuers: ApiRequestProtocol {
        var method: HttpMethods = .get
        var url: String = baseUrl + "payment_methods/card_issuers"
        var headers: [String: String]? = [:]
        var parameters: [String: Any]?

        init(paymentMethodId: String?) {
            self.parameters = [
                "public_key": apiKey,
                "payment_method_id": paymentMethodId ?? ""
            ]
        }

        func parser(_ error: Error?, _ data: JSON?, _ code: Int?, _ handler: ApiHandler?) {
            if let error = error {
                handler?(error)
                return
            }

            guard let data = data else { return }
            let banks = data.mapArray() as [Bank]

            if banks.count == 0 {
                handler?(NSError.emptyData)
                return
            }

            handler?(banks)
        }
    }

    class Installments: ApiRequestProtocol {
        var method: HttpMethods = .get
        var url: String = baseUrl + "payment_methods/installments"
        var headers: [String: String]? = [:]
        var parameters: [String: Any]?

        init(paymentMethodId: String?, issuerId: Int?, amount: Double) {
            self.parameters = [
                "public_key": apiKey,
                "amount": amount,
                "payment_method_id": paymentMethodId ?? "",
                "issuer.id": issuerId ?? ""
            ]
        }

        func parser(_ error: Error?, _ data: JSON?, _ code: Int?, _ handler: ApiHandler?) {
            if let error = error {
                handler?(error)
                return
            }

            guard let data = data?.arrayValue.first else { return }
            let items = data["payer_costs"].mapArray() as [Installment]

            if items.count == 0 {
                handler?(NSError.emptyData)
                return
            }

            handler?(items)
        }
    }
}
