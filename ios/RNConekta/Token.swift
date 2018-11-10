//
//  Token.swift
//  RCTConekta
//
//  Created by César Guadarrama on 8/19/18.
//  Copyright © 2018 Nure. All rights reserved.
//

import Foundation

class Token {
    private let resourceURI = "/tokens"
    private let publicKey: String
    
    private let card: Card

    private lazy var apiKeyBase64: String = {
        let plainData = self.publicKey.data(using: .utf8)!
        let apiKeyBase64Data = plainData.base64EncodedData(options: .lineLength64Characters)
        let returnValue = String.init(data: apiKeyBase64Data, encoding: .utf8)!

        return returnValue
    }()

    init(card: Card, publicKey: String, baseURI: String, handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.card = card
        self.publicKey = publicKey

        let url = URL.init(string: "\(baseURI)\(resourceURI)")
        var urlRequest = URLRequest(url: url!)

        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Basic \(self.apiKeyBase64)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")

        urlRequest.httpBody = self.card.asJSONData()

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let dataTask = session.dataTask(with: urlRequest, completionHandler: handler)
        dataTask.resume()

    }
}
