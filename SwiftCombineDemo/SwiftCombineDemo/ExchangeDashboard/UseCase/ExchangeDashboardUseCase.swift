//
//  ExchangeDashboardUseCase.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import Foundation
protocol ExchangeDashboardUseCaseOutput {
    func didFetch(data: ExchangeRate)
    func didSetError(error: GenericResponse)
}

final class ExchangeDashboardUseCase: ObservableObject {
    let manager = ConversionRateManager()
    @Published var listOfExchangeRate: ExchangeRate = [:]
    @Published var error: GenericResponse = .returnPseudoObj()

    init() {
    }
    func getCurrencies() {
        guard !manager.isCacheValid else {
            Logger.log(type: .success, msg: "Exchange rates from local cache fetched")
            listOfExchangeRate = manager.fetchExchangeRate() ?? [:]
            return
        }
        Network.catalogue { results in
            switch results {
            case .success(let data):
                Logger.log(type: .success, msg: "Network Request Successfull")
                self.updateLocalDB(rates: data.conversionRates)
                self.listOfExchangeRate = data.conversionRates
            case .failure(let error):
                Logger.log(type: .success, msg: "Network Request Failed \(String(describing: error.localizedDescription))")
                self.error = error
            }
        }
    }
 
    private func updateLocalDB(rates: ExchangeRate) {
        rates.forEach { dict in
            manager.append(country: dict.key, exchangeRate: dict.value)
        }
        UserDefaultHelper.instance.lastUpdateTimeStamp = Date().currentUnixTimeStamp
    }
    private func returnUnitValue(_ baseCurrency: String, _ targetCurrency: String) -> Double {
         ((listOfExchangeRate[baseCurrency] ?? 0.0) / (listOfExchangeRate[targetCurrency] ?? 0.0))
    }
    func convert(_ baseCurrency: String, _ targetCurrency: String, units: String) -> (Double, Double) {
        let units = (Double(units) ?? 0.0)
        let ratePerUnit = returnUnitValue(baseCurrency, targetCurrency)
        return ((units * ratePerUnit).rounded(toPlaces: 4), ratePerUnit)
    }
    func isValidSelection(_ baseCurrency: String, targetCurrency: String) -> Bool {
        return listOfExchangeRate[baseCurrency] != nil && (listOfExchangeRate[targetCurrency] != nil)
    }
}
