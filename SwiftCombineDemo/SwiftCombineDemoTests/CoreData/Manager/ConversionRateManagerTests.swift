//
//  ExchangeRateManager.swift
//  SwiftCombineDemoTests
//
//  Created by Admin on 1/31/23.
//

import Foundation

import XCTest
@testable import SwiftCombineDemo
class ConversionRateManagerTests: XCTestCase {
    func testIfItemAppends() {
        let manager = ConversionRateManager()
        manager.clearAll()
        manager.append(country: "USD", exchangeRate: 1.0)
        try XCTAssertEqual(1, XCTUnwrap(manager.fetchExchangeRate()?.count))
    }
    func testIfNoDuplicateItemAppends() {
        let manager = ConversionRateManager()
        manager.clearAll()
        manager.append(country: "USD", exchangeRate: 1.0)
        manager.append(country: "USD", exchangeRate: 1.0)
        manager.append(country: "USD", exchangeRate: 1.0)
        manager.append(country: "USD", exchangeRate: 1.0)
        manager.append(country: "USD", exchangeRate: 1.0)
        manager.append(country: "USD", exchangeRate: 1.0)
        manager.append(country: "USD", exchangeRate: 1.0)
        try XCTAssertEqual(1, XCTUnwrap(manager.fetchExchangeRate()?.count))
    }
    func testIfFetchItemReturnCorrectObject() {
        let manager = ConversionRateManager()
        manager.append(country: "AED", exchangeRate: 3.65)
        let result = manager.fetchExchangeRate(byIdentifier: "AED")
        try XCTAssertEqual(3.65, XCTUnwrap(result))
    }
    func testIfClearAllDeleteAllItem() {
        let manager = ConversionRateManager()
        manager.append(country: "AED", exchangeRate: 3.65)
        manager.append(country: "INR", exchangeRate: 80.1)
        manager.append(country: "GBP", exchangeRate: 1.2)
        manager.clearAll()
        let result = manager.fetchExchangeRate()
        try XCTAssertEqual(XCTUnwrap(result?.count), 0)
    }
}
