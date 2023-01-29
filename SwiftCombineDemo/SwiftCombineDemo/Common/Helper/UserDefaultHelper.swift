//
//  UserDefaultHelper.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/29/23.
//

import UIKit
class UserDefaultHelper {
    let helper = UserDefaults.standard
    static let instance = UserDefaultHelper()
    func putInt(key: String, value: Int) {
        helper.set(value, forKey: key)
        helper.synchronize()
    }
    func getInt(key: String) -> Int {
        var value = 0
        if helper.object(forKey: key) != nil {
            value = helper.integer(forKey: key)
        }
        return value
    }
    func clearAllUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
extension UserDefaultHelper {
    var lastUpdateTimeStamp: Int {
        get {
            getInt(key: #function)
        }
        set(count) {
            putInt(key: #function, value: count)
        }
    }
   
}
