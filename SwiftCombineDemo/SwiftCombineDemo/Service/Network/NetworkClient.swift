//
//  NetworkClient.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//
//


import Foundation
import Alamofire
import Foundation
final class NetworkClient {
    let session: Session
    private init() {
        let manager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:])
        
        self.session = Session(
            interceptor: CustomRequestAdapter(),
            serverTrustManager: manager
        )
    }
    
    private static let shared = NetworkClient()
    static func request(_ convertible: URLRequestConvertible) -> DataRequest {
        let request = shared.session.request(convertible)
        return request.validate(statusCode: 200..<401).validate(contentType: [ContentType.json.rawValue, ContentType.text.rawValue])
    }
}

enum ContentType: String {
    case json = "application/json"
    case text = "text/html"
}
