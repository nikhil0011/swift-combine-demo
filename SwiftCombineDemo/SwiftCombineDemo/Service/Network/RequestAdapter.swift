//
//  RequestAdapter.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//
import Alamofire
import Foundation

final class CustomRequestAdapter: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        completion(.success(urlRequest))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        completion(.doNotRetryWithError(error))
    }
}
