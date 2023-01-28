//
//  Network.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//


import Foundation
import Alamofire
typealias HTTPResponse<T: Decodable> = (Result<T, GenericResponse>) -> Void
protocol NetworkClientProtocol {
    static func performRequest<T: Decodable>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>)
}
class Network: NetworkClientProtocol {
   static func performRequest<T: Decodable>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>) {
       guard let router = router else { return }
        NetworkClient.request(router).responseDecodable(of: T.self) { (response) in
            switch response.result {
            case let .success(value):
                DispatchQueue.main.async {
                    completion(.success(value))
                }
            case .failure(_):
                var httpError: GenericResponse
                if let data = response.data, let parsedData = try? JSONDecoder().decode(GenericResponse.self, from: data) {
                    httpError = parsedData
                    DispatchQueue.main.async {
                        completion(.failure(httpError))
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = GenericResponse.returnPseudoObj()
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    static func catalogue(completion: @escaping HTTPResponse<Currency>) {
        performRequest(CurrecnyAPIRouter.currency, completion: completion)
    }
}
