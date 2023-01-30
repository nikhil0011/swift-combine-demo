//
//  CurrencyView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/29/23.
//

import SwiftUI

struct CurrencyView: View {
    @State private var firstFieldValue = "Field 1"
    @State private var secondFieldValue = "Field 2"
    @State private var thirdFieldValue = ""
    @State private var showFirstPicker = false
    @State private var showSecondPicker = false
    let pickerData2: ExchangeRate = ["PKR": 1, "INR": 80, "AED": 3.65]
    
    let pickerData: ExchangeRate = ["USD": 1, "INR": 80, "AED": 3.65]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                FirstSubView(firstValue: $firstFieldValue, showPicker: $showFirstPicker, pickerData: pickerData).onTapGesture {
                    if showSecondPicker {
                        self.showSecondPicker = false
                    }
                }
                SecondSubView(secondValue: $secondFieldValue, showPicker: $showSecondPicker, pickerData: pickerData2).onTapGesture {
                    if showFirstPicker {
                        self.showFirstPicker = false
                    }
                }
            }
            .padding()
            ResultTextFieldView(result: $thirdFieldValue)
            if showFirstPicker {
                PickerView(list: pickerData, selectedValue: $firstFieldValue)
            }
            if showSecondPicker {
                PickerView(list: pickerData2, selectedValue: $secondFieldValue)
            }
        }
    }
}


struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
