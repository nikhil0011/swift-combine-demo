//
//  SecondSubView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI

struct SecondSubView: View {
    @Binding var secondValue: String
    @Binding var showPicker: Bool
    var pickerData: ExchangeRate
    var body: some View {
        Button(action: {
            self.showPicker.toggle()
        }) {
            Text(secondValue)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .border(Color.black, width: 1.0)
                .foregroundColor(.black)
        }
    }
}
