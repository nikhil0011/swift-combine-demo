//
//  ResultTextFieldView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/30/23.
//

import SwiftUI

struct ResultTextFieldView: View {
    @Binding var result: String
    
    var body: some View {
        TextField("Enter value", text: $result)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .border(Color.black, width: 1.0)
            .foregroundColor(.black)
            .padding()
            .keyboardType(.decimalPad)
    }
}
