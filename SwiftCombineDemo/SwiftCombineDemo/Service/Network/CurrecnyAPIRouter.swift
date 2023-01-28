//
//  CatalogueAPIRouter.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import Foundation
import Alamofire
enum CurrecnyAPIRouter: APIConfiguration {
    case currency
    var method: HTTPMethod {
        switch self {
        case .currency: return .get
        }
    }
    var path: String {
        switch self {
        case .currency:
            return Endpoint.currency
        }
    }
    var parameters: Parameters? {
        switch self {
        case .currency: return nil
        }
    }
    var host: String {
        switch self {
        case .currency:
            return BASEURL
        }
    }
   
}
