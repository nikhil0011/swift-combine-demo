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
    let manager = ConversionRateManager()
    func testIfItemAppends() {
        manager.clearAll()
        manager.append(country: "USD", exchangeRate: 1.0)
        try XCTAssertEqual(1, XCTUnwrap(manager.fetchExchangeRate()?.count))
    }
    func testIfNoDuplicateItemAppends() {
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
        manager.append(country: "AED", exchangeRate: 3.65)
        let result = manager.fetchExchangeRate(byIdentifier: "AED")
        try XCTAssertEqual(3.65, XCTUnwrap(result))
    }
    func testIfClearAllDeleteAllItem() {
        manager.append(country: "AED", exchangeRate: 3.65)
        manager.append(country: "INR", exchangeRate: 80.1)
        manager.append(country: "GBP", exchangeRate: 1.2)
        manager.clearAll()
        let result = manager.fetchExchangeRate()
        try XCTAssertEqual(XCTUnwrap(result?.count), 0)
    }
    func testIsCacheValidAfterFiveHours() {
        let currentTime = Date().currentUnixTimeStamp
        let lastUpdateTime = UserDefaultHelper.instance.lastUpdateTimeStamp
        XCTAssertEqual(manager.isCacheValid(currentTime, lastUpdateTime-20000), false)
    }
    func testIsCacheValidUnderFiveHours() {
        let currentTime = Date().currentUnixTimeStamp
        let lastUpdateTime = UserDefaultHelper.instance.lastUpdateTimeStamp
        XCTAssertEqual(manager.isCacheValid(currentTime, lastUpdateTime-10000), false)
    }
}
