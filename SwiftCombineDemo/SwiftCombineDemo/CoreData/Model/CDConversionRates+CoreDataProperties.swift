//
//  CDConversionRates+CoreDataProperties.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/29/23.
//
//

import Foundation
import CoreData


extension CDConversionRates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDConversionRates> {
        return NSFetchRequest<CDConversionRates>(entityName: "CDConversionRates")
    }

    @NSManaged public var country: String?
    @NSManaged public var exchangeRate: Double
    func makeItem() -> Currency {
        Currency(result: "", documentation: "", termsOfUse: "", timeLastUpdateUnix: 0, timeLastUpdateUTC: "", timeNextUpdateUnix: 0, timeNextUpdateUTC: "", baseCode: "", conversionRates: [country ?? "": exchangeRate])
    }
}

extension CDConversionRates : Identifiable {

}
