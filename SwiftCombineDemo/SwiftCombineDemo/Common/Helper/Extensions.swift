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
