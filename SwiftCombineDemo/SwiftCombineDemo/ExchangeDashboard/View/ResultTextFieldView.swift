//
//  ResultTextFieldView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI

struct ResultTextFieldView: View {
    @Binding var result: String
    let placeholder = "Enter value"
    var body: some View {
        TextField(placeholder, text: $result)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(minHeight: 44)
            .font(.title3)
            .border(Color.black, width: 0.4)
            .foregroundColor(.black)
            .padding().padding()
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
    }
}
