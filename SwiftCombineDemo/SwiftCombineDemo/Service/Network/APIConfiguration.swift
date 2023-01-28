//
//  APIConfiguration.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//
import Foundation
import Alamofire
protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var host: String { get }
}
extension APIConfiguration {
    func returnBaseUrl() -> URL {
        URL(string: host + path) ?? ERROR_PAGE_URL
    }
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: returnBaseUrl())
        urlRequest.httpMethod = method.rawValue
        _ = urlRequest.setHeader()
        guard method == .get else {
            return urlRequest
        }
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
extension URLRequest {
    mutating func setHeader() -> URLRequest {
        return self
    }
}
