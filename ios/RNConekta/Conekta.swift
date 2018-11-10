//
//  Conekta.swift
//  conekta-react-native
//
//  Created by César Guadarrama on 8/18/18.
//  Copyright © 2018 Nure. All rights reserved.
//

import Foundation
import UIKit

@objc(Conekta)
class Conekta: NSObject {
    let BASE_URL = "https://api.conekta.io"
    var PUBLIC_KEY = ""

    private lazy var apiKeyBase64: String = {
        let plainData = self.PUBLIC_KEY.data(using: .utf8)!
        let apiKeyBase64Data = plainData.base64EncodedData(options: .lineLength64Characters)
        return String.init(data: apiKeyBase64Data, encoding: .utf8)!
    }()

    let deviceFingerprint: String? = {
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        return uuid?.replacingOccurrences(of: "-", with: "")
    }()

    @objc func setPublicKey(_ publicKey: String) {
        self.PUBLIC_KEY = publicKey
        self.collectDevice() // Register device
    }

    func collectDevice() {
        guard let sessionId = deviceFingerprint else {
            print("Could not get device fingerprint")
            return
        }

        let html = "<html style=\"background: blue;\"><head></head><body><script type=\"text/javascript\" src=\"https://conektaapi.s3.amazonaws.com/v0.5.0/js/conekta.js\" data-conekta-public-key=\"\(self.PUBLIC_KEY)\" data-conekta-session-id=\"\(sessionId)\"></script></body></html>"
        DispatchQueue.main.async {
            let web = UIWebView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            web.loadHTMLString(html, baseURL: nil)
            web.scalesPageToFit = true

            let rootViewController = UIApplication.shared.delegate?.window??.rootViewController

            rootViewController?.view.addSubview(web)
            // Since we dont remove the view, this may be a memory leak
        }
    }

    @objc func createToken(
        _ number: String,
        name: String,
        cvc: String,
        expMonth: String,
        expYear: String,
        callback: @escaping RCTResponseSenderBlock
        ) {

        print("CREATING TOKEN")

        // You won't be on the main thread when called from JavaScript
        let deviceFingerprint = self.deviceFingerprint ?? ""

        let jsonString = "{\"card\":{\"name\":\"\(name)\",\"number\":\"\(number)\",\"cvc\":\"\(cvc)\",\"exp_month\":\"\(expMonth)\",\"exp_year\": \"\(expYear)\", \"device_fingerprint\":\"\(deviceFingerprint)\"}}"

        // Create request
        let url = URL.init(string: "\(self.BASE_URL)/tokens")
        var urlRequest = URLRequest(url: url!)

        urlRequest.httpMethod = "POST"

        urlRequest.addValue("Basic \(self.apiKeyBase64)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
        urlRequest.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")

        urlRequest.httpBody = jsonString.data(using: .utf8, allowLossyConversion: true)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        // Define request
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data, let responseString = String(data: data, encoding: .utf8)  {
                print("RESPONSE", responseString)
                callback([nil, responseString])
            } else {
                print("NO RESPONSE")
                callback(["Could not get response data", nil])
            }
        }

        // Start request
        dataTask.resume()
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
}
