//
//  ContentView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var useCase: ExchangeDashboardUseCase
    @State private var baseCurrencyValue = "Choose the base country"
    @State private var targetCurrencyValue = "Choose the target country"
    @State private var inputTextFieldValue = ""
    @State private var showBaseCurrencyPicker = false
    @State private var showTargetCurrencyPicker = false
    @State private var errorString: String = ""
    let manager = ConversionRateManager()
    private var dataSource: DataSource {
        let data = useCase.convert(baseCurrencyValue, targetCurrencyValue, units: inputTextFieldValue)
        let dataSource = DataSource()
        dataSource.baseCurrencyAmount = inputTextFieldValue + " " + baseCurrencyValue
        dataSource.targetCurrentAmount = "\(data.0) \(targetCurrencyValue)"
        dataSource.rate = data.1
        return dataSource
    }
    private var isValidInput: Bool {
        let isValidSelection = useCase.isValidSelection(baseCurrencyValue, targetCurrency: targetCurrencyValue)
        guard  (Double(inputTextFieldValue) != nil), isValidSelection else {
            return false
        }
        return true
    }
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    HStack {
                        BaseCurrencySelectionView(firstValue: $baseCurrencyValue, showPicker: $showBaseCurrencyPicker).onTapGesture {
                            if showTargetCurrencyPicker {
                                self.showTargetCurrencyPicker = false
                            }
                        }
                        TargetCurrencySelectionView(secondValue: $targetCurrencyValue, showPicker: $showTargetCurrencyPicker).onTapGesture {
                            if showBaseCurrencyPicker {
                                self.showBaseCurrencyPicker = false
                            }
                        }
                    }
                    .padding()
                    ResultTextFieldView(result: $inputTextFieldValue)
                    NavigationLink(destination: PreConfirmationView(data: dataSource)) {
                        Text("Calculate")
                            .foregroundColor(.white)
                            .padding()
                            .background(isValidInput ? Color.orange : Color.gray)
                            .cornerRadius(5)
                    }.disabled(!isValidInput)
                    Text(errorString)
                }
                if showBaseCurrencyPicker {
                    PickerView(list: useCase.listOfExchangeRate, isShowing: $showBaseCurrencyPicker, selectedValue: $baseCurrencyValue)
                        .offset(y: self.showBaseCurrencyPicker ? 0 : UIScreen.main.bounds.height)
                        .animation(Animation.easeInOut(duration: 1.0), value: showBaseCurrencyPicker)
                    
                }
                if showTargetCurrencyPicker {
                    PickerView(list: useCase.listOfExchangeRate, isShowing: $showTargetCurrencyPicker, selectedValue: $targetCurrencyValue)
                        .offset(y: self.showTargetCurrencyPicker ? 0 : UIScreen.main.bounds.height)
                        .animation(Animation.easeInOut(duration: 1.0), value: showTargetCurrencyPicker)
                    
                }
            }
        }.onAppear(perform: {
            useCase.getCurrencies()
        })
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(useCase: .init())
    }
}
