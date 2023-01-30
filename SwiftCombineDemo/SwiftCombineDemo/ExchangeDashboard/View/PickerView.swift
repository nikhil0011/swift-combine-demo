//
//  PickerView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI
struct PickerView: View {
    var list: ExchangeRate
    @Binding var selectedValue: String
    var pickerArray: [(key: String, value: Double)] {
        let list = list.sorted { value1, value2 in
            value1.key < value2.key
        }
        return Array(list.map { key, value in (key, value)})
    }
    var body: some View {
        Picker("", selection: $selectedValue) {
            ForEach(pickerArray, id: \.0) { key, value in
                Text(key).tag(value)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .labelsHidden()
        .frame(minHeight: 300)
        .padding()
        .shadow(radius: 10)
    }
}