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

final class ExchangeDashboardUseCase {
    let manager = ConversionRateManager()
    let output: ExchangeDashboardUseCaseOutput
    init(output: ExchangeDashboardUseCaseOutput) {
        self.output = output
    }
    func getCurrencies() {
        guard !manager.isCacheValid else {
            Logger.log(type: .success, msg: "Exchange rates from local cache fetched")
            output.didFetch(data: manager.fetchExchangeRate() ?? [:])
            return
        }
        Network.catalogue { results in
            switch results {
            case .success(let data):
                Logger.log(type: .success, msg: "Network Request Successfull")
                self.updateLocalDB(rates: data.conversionRates)
                self.output.didFetch(data: data.conversionRates)
            case .failure(let error):
                Logger.log(type: .success, msg: "Network Request Failed \(String(describing: error.localizedDescription))")
                self.output.didSetError(error: error)
            }
        }
    }
    private func updateLocalDB(rates: ExchangeRate) {
        rates.forEach { dict in
            manager.append(country: dict.key, exchangeRate: dict.value)
        }
        UserDefaultHelper.instance.lastUpdateTimeStamp = Date().currentUnixTimeStamp
    }
}
