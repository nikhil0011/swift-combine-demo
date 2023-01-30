//
//  PickerView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI
struct PickerView: View {
    var list: ExchangeRate
    @Binding var isShowing: Bool
    @Binding var selectedValue: String
    var pickerArray: [(key: String, value: Double)] {
        let list = list.sorted { value1, value2 in
            value1.key < value2.key
        }
        return Array(list.map { key, value in (key, value)})
    }
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.isShowing = false
            }) {
                HStack {
                    Spacer()
                    Text("Close")
                        .padding(.horizontal, 16)
                }
            }
            Picker("", selection: $selectedValue) {
                ForEach(pickerArray, id: \.0) { key, value in
                    Text(key).tag(value)
                }
            }
            .frame(width: 200)
            .labelsHidden()
            .pickerStyle(.wheel)
        }
    }
}
