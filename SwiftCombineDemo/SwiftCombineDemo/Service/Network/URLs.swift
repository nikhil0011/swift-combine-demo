//
//  URLs.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import Foundation

let BASEURL = "https://v6.exchangerate-api.com/v6"
let TOKEN = "f4d5fa9ab61f803767a69728"
let ERROR_PAGE_URL = URL(string: "\(BASEURL)/404")!
struct Endpoint {
    static let currency = "/\(TOKEN)/latest/USD"
}

