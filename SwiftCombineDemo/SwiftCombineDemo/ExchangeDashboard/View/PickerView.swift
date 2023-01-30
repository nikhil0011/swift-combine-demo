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
        Array(list.map { key, value in (key, value)})
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
