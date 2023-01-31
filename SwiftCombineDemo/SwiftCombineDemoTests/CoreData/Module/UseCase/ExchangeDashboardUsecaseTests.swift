//
//  ExchangeDashboardUsecase.swift
//  SwiftCombineDemoTests
//
//  Created by Admin on 1/31/23.
//

import XCTest
import UIKit
import Combine
@testable import SwiftCombineDemo
final class ExchangeDashboardUsecaseTests: XCTestCase {
    func testGetcurrencies() {
        let spy = ExchangeDashboardOutputSpy()
        spy.getCurrencies()
        waitUntil(spy.$listOfExchangeRate, equals: ["USD": 1.0, "INR": 80.0])
        XCTAssertEqual(spy.listOfExchangeRate.count, 2)
    }
    func testError() {
        let spy = ExchangeDashboardOutputFailureSpy()
        spy.getCurrencies()
        waitUntil(spy.$error, equals: GenericResponse(success: true, status: 401))
        XCTAssertTrue(spy.error.success)
    }
}
private class ExchangeDashboardOutputSpy: ExchangeDashboardUseCaseProtocol {
    var isValidCache: Bool {
        true
    }
    
    @Published var listOfExchangeRate: SwiftCombineDemo.ExchangeRate = [:]
    @Published var error: SwiftCombineDemo.GenericResponse = .returnPseudoObj()

    func getCurrencies() {
        DispatchQueue.main.asyncAfter(deadline: .now() +  3.0, execute: {
            self.listOfExchangeRate = ["USD": 1.0, "INR": 80.0]
        })
    }
    
    func convert(_ baseCurrency: String, _ targetCurrency: String, units: String) -> (Double, Double) {
        return (0.0,0.0)
    }
}
private class ExchangeDashboardOutputFailureSpy: ExchangeDashboardUseCaseProtocol {
    var isValidCache: Bool {
        true
    }
    
    @Published var listOfExchangeRate: SwiftCombineDemo.ExchangeRate = [:]
    @Published var error: SwiftCombineDemo.GenericResponse = .returnPseudoObj()

    func getCurrencies() {
        DispatchQueue.main.asyncAfter(deadline: .now() +  3.0, execute: {
            let err = GenericResponse(success: true, status: 401)
            self.error = err
        })
    }
    
    func convert(_ baseCurrency: String, _ targetCurrency: String, units: String) -> (Double, Double) {
        return (0.0,0.0)
    }
}
extension XCTestCase {
    func waitUntil<T: Equatable>(
        _ propertyPublisher: Published<T>.Publisher,
        equals expectedValue: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let expectation = expectation(
            description: "Awaiting value \(expectedValue)"
        )
        
        var cancellable: AnyCancellable?
        
        cancellable = propertyPublisher
            .dropFirst()
            .first(where: { $0 == expectedValue })
            .sink { value in
                XCTAssertEqual(value, expectedValue, file: file, line: line)
                cancellable?.cancel()
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
extension GenericResponse: Equatable {
    static public func ==(lhs: GenericResponse, rhs: GenericResponse) -> Bool {
        lhs.success == rhs.success && lhs.status == rhs.status
    }
}
