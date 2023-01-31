//
//  ConversionRateRepository.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/29/23.
//

import Foundation
import CoreData

protocol ConversionRateRepositoryProtocol {
    func create(country: String, exchangeRate: Double)
    func getAll() -> ExchangeRate?
    func get(byIdentifier id: String) -> Double?
    func update(exchangeRate: ExchangeRate) -> Bool
    func delete(id: String) -> Bool
}

struct ConversionRateRepository : ConversionRateRepositoryProtocol {
    func create(country: String, exchangeRate: Double) {
        let cdConversionRate = CDConversionRates(context: PersistentStorage.shared.context)
        cdConversionRate.exchangeRate = exchangeRate
        cdConversionRate.country = country
        PersistentStorage.shared.saveContext()
    }
    func getAll() -> ExchangeRate? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDConversionRates.self)
        var exchangeRates : ExchangeRate = [:]
        result?.forEach({ (CDConversionRates) in
            exchangeRates[CDConversionRates.country ?? ""] = CDConversionRates.exchangeRate
        })
        return exchangeRates
    }
    func get(byIdentifier id: String) -> Double? {
        guard let item = getItem(byIdentifier: id) else {return nil}
        return item.makeItem().conversionRates.first?.value
    }
    private func getItem(byIdentifier id: String) -> CDConversionRates? {
        let fetchRequest = NSFetchRequest<CDConversionRates>(entityName: "CDConversionRates")
        let predicate = NSPredicate(format: "country==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard let resultItem = result else {return nil}
            return resultItem
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    func update(exchangeRate: ExchangeRate) -> Bool {
        for rate in exchangeRate {
            let result = getItem(byIdentifier: rate.key)
            guard let conversionRate = result  else {
                return false
            }
            conversionRate.exchangeRate = rate.value
            PersistentStorage.shared.saveContext()
        }
        return true
    }
    
    func delete(id: String) -> Bool {
        guard let conversionRate = getItem(byIdentifier: id) else {
            return false
        }
        PersistentStorage.shared.context.delete(conversionRate)
        return true
    }
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDConversionRates")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try PersistentStorage.shared.context.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            Logger.log(type: .info, msg: "Error in deleting all data\(error.localizedDescription)")
        }
    }
}
