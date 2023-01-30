//
//  ConversionRateManager.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/29/23.
//

import Foundation
struct ConversionRateManager {

    private let conversionRepository: ConversionRateRepository = ConversionRateRepository()
    
    func append(country: String, exchangeRate: Double) {
        conversionRepository.create(country: country, exchangeRate: exchangeRate)
    }
    
    func fetchExchangeRate() -> ExchangeRate? {
        return conversionRepository.getAll()
    }
    
    func fetchExchangeRate(byIdentifier id: String) -> Double?
    {
        return conversionRepository.get(byIdentifier: id)
    }
    
    func updateExchangeRate(item: ExchangeRate) -> Bool {
        return conversionRepository.update(exchangeRate: item)
    }
    
    func deleteExchangeRate(id: String) -> Bool {
        return conversionRepository.delete(id: id)
    }
    func clearAll() {
        let items = fetchExchangeRate()
        items?.forEach {
            _ = deleteExchangeRate(id: $0.key)
        }
    }
    var isCacheValid: Bool {
        let currentTime = Date().currentUnixTimeStamp
        let lastUpdateTime = UserDefaultHelper.instance.lastUpdateTimeStamp
        return (currentTime - lastUpdateTime) < 18000
    }
}
    