//
//  Card.swift
//  conekta-swift
//
//  Created by César Guadarrama on 8/18/18.
//

import Foundation

class Card {
    private let baseURI: String
    private let publicKey: String
    private let resourceURI = "/cards"

    private let number, name, cvc, expMonth, expYear, deviceFingerprint: String

    init(number: String, name: String, cvc: String, expMonth: String, expYear: String, deviceFingerprint: String, baseURI: String, publicKey: String) {
        self.number = number
        self.name = name
        self.cvc = cvc
        self.expMonth = expMonth
        self.expYear = expYear
        self.deviceFingerprint = deviceFingerprint


        self.baseURI = baseURI
        self.publicKey = publicKey
    }

    func asJSONData() -> Data {
        let json = "{\"card\":{\"name\":\"\(self.name)\",\"number\":\"\(self.number)\",\"cvc\":\"\(self.cvc)\",\"exp_month\":\"\(self.expMonth)\",\"exp_year\": \"\(self.expYear)\", \"device_fingerprint\":\"\(self.deviceFingerprint)\"}}"
        return json.data(using: .utf8)!
    }

    func createToken(handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let _ = Token.init(card: self, publicKey: self.publicKey, baseURI: self.baseURI, handler: handler)
    }
}
