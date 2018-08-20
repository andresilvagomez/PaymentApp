//
//  Api.swift
//  MercadoPago
//
//  Created by Andres Silva on 8/16/18.
//  Copyright © 2018 Andres Silva. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias ApiHandler = ( (_ result: Any) -> Void )
typealias PreApiHandler = ( (_ error: Error?, _ data: JSON?, _ code: Int?, _ handler: ApiHandler?) -> Void )

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

protocol ApiRequestProtocol: class {
    var method: HttpMethods { get }
    var url: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }

    func parser(_ error: Error?, _ data: JSON?, _ code: Int?, _ handler: ApiHandler?)
}

class Api {
    func request(_ request: ApiRequestProtocol, handler: ApiHandler?) {
        guard let urlRequest = build(request: request) else {
            let error = NSError(message: "We can't build your request")
            handler?(error)
            return
        }

        DispatchQueue.global(qos: .background).async {
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else {
                    let error = NSError(message: "We have some error in the response")
                    handler?(error)
                    return
                }

                guard let data = data else {
                    let error = NSError(message: "We can't parse access to response data")
                    handler?(error)
                    return
                }

                let json = JSON(data)
                DispatchQueue.main.async {
                    request.parser(error, json, response.statusCode, handler)
                }
            }

            task.resume()
        }
    }

    func uri(request: ApiRequestProtocol) -> URL? {
        let url = URL(string: request.url)

        if request.method == .post {
            return url
        }

        guard var urlComponents = URLComponents(string: request.url) else {
            return url
        }

        guard let parameters = request.parameters else {
            return url
        }

        urlComponents.queryItems = []
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(item)
        }
        return urlComponents.url
    }

    private func build(request: ApiRequestProtocol) -> URLRequest? {
        guard let uri = uri(request: request) else {
            return nil
        }
        var urlRequest = URLRequest(url: uri)
        urlRequest.httpMethod = request.method.rawValue

        if let headers = request.headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        if request.method == .post {
            urlRequest.httpBody = jsonData(request: request)
        }

        return urlRequest
    }

    private func jsonData(request: ApiRequestProtocol) -> Data? {
        guard let parameters = request.parameters else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}
