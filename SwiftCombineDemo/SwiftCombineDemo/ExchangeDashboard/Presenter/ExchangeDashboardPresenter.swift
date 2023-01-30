//
//  ExchangeDashboardPresenter.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import Foundation


protocol ExchangeDashboardPresenterOutput {
    func showDashboard(exchangeRate: ExchangeRate)
    func showError(error: GenericResponse)
}
final class ExchangeDashboardPresenter: ExchangeDashboardUseCaseOutput {
    let output: ExchangeDashboardPresenterOutput
    init(output: ExchangeDashboardPresenterOutput) {
        self.output = output
    }
    
    func didFetch(data: ExchangeRate) {
        output.showDashboard(exchangeRate: data)
    }
    func didSetError(error: GenericResponse) {
        output.showError(error: error)
    }
}
