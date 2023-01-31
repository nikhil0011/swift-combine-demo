//
//  NetworkTests.swift
//  SwiftCombineDemoTests
//
//  Created by Admin on 1/31/23.
//

import XCTest

@testable import SwiftCombineDemo
class NetworkTests: XCTestCase {
    func test_performAlwaysSuccessRequest() {
        AlwaysSuccessOutputSpy.exchangeRates(completion: { (results) in
            switch results {
            case .success(let data):
                XCTAssertEqual(data.conversionRates.count, 3)
                break
            case .failure(_):
                break
            }
        })
    }
    func test_performAlwaysFailedRequest() {
        AlwaysFailedOutputSpy.exchangeRates(completion: { (results) in
            switch results {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual(error.success, false)
                break
            }
        })
    }
    private class AlwaysSuccessOutputSpy: NetworkClientProtocol {
        static func performRequest<T>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>) where T : Decodable {
            let items = Currency(result: "", documentation: "", termsOfUse: "", timeLastUpdateUnix: 0, timeLastUpdateUTC: "", timeNextUpdateUnix: 0, timeNextUpdateUTC: "", baseCode: "", conversionRates: ["USD": 1.0, "EURO": 1.1, "AED": 3.65])
            completion(.success(items as! T))
        }
        static func exchangeRates(completion: @escaping HTTPResponse<Currency>) {
            performRequest(nil, completion: completion)
        }
        
    }
    private class AlwaysFailedOutputSpy: NetworkClientProtocol {
        static func performRequest<T>(_ router: APIConfiguration?, completion: @escaping HTTPResponse<T>) where T : Decodable {
            let error = GenericResponse("API Failed")
            completion(.failure(error))

        }
        static func exchangeRates(completion: @escaping HTTPResponse<Currency>) {
            performRequest(nil, completion: completion)
        }
    }
}
