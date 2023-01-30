//
//  Extensions.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/29/23.
//

import Foundation
extension Date {
    var currentUnixTimeStamp: Int {
        Int(Date().timeIntervalSince1970)
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
