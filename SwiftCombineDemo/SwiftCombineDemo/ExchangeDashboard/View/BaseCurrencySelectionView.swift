//
//  FirstSubView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI

struct BaseCurrencySelectionView: View {
    @Binding var firstValue: String
    @Binding var showPicker: Bool
    var body: some View {
        Button(action: {
            self.showPicker.toggle()
        }) {
            Text(firstValue)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                .border(Color.black, width: 0.4)
                .foregroundColor(.black)
                .frame(minHeight: 44)
                .font(.body)
                .padding()
        }
    }
}
