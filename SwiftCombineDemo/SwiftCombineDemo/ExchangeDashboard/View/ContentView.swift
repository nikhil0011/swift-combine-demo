//
//  ContentView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var baseCurrencyValue = "Choose the base country"
    @State private var targetCurrencyValue = "Choose the target country"
    @State private var thirdFieldValue = ""
    @State private var showBaseCurrencyPicker = false
    @State private var showTargetCurrencyPicker = false
    @State private var pickerData2: ExchangeRate = [:]
    @State private var pickerData: ExchangeRate = [:]
    @State private var errorString: String = ""
    let manager = ConversionRateManager()
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    HStack {
                        BaseCurrencySelectionView(firstValue: $baseCurrencyValue, showPicker: $showBaseCurrencyPicker, pickerData: pickerData).onTapGesture {
                            if showTargetCurrencyPicker {
                                self.showTargetCurrencyPicker = false
                            }
                        }
                        TargetCurrencySelectionView(secondValue: $targetCurrencyValue, showPicker: $showTargetCurrencyPicker, pickerData: pickerData2).onTapGesture {
                            if showBaseCurrencyPicker {
                                self.showBaseCurrencyPicker = false
                            }
                        }
                    }
                    .padding()
                    ResultTextFieldView(result: $thirdFieldValue)
                    NavigationLink(destination: PreConfirmationView(data: getData())) {
                            Text("Calculate")
                                .foregroundColor(.white)
                                .padding()
                                .background(isValidInput ? Color.orange : Color.gray)
                                .cornerRadius(5)
                    }.disabled(!isValidInput)
                    Text(errorString)
                }
                if showBaseCurrencyPicker {
                    PickerView(list: pickerData, isShowing: $showBaseCurrencyPicker, selectedValue: $baseCurrencyValue)
                        .offset(y: self.showBaseCurrencyPicker ? 0 : UIScreen.main.bounds.height)
                        .animation(Animation.easeInOut(duration: 1.0), value: showBaseCurrencyPicker)
                    
                }
                if showTargetCurrencyPicker {
                    PickerView(list: pickerData2, isShowing: $showTargetCurrencyPicker, selectedValue: $targetCurrencyValue)
                        .offset(y: self.showTargetCurrencyPicker ? 0 : UIScreen.main.bounds.height)
                        .animation(Animation.easeInOut(duration: 1.0), value: showTargetCurrencyPicker)
                    
                }
                
            }
        }.onAppear(perform: {
            getCurrencies()
        })
    }
    private var isValidInput: Bool {
        guard  (Double(thirdFieldValue) != nil),
                (pickerData[baseCurrencyValue] != nil),
                (pickerData[targetCurrencyValue] != nil) else {
            return false
        }
        return true
    }
    private func getData() -> DataSource {
        let baseCurrency = pickerData[baseCurrencyValue] ?? 0.0
        let targetCurrencyBaseValue = pickerData[targetCurrencyValue] ?? 0.0
        let unitCost = targetCurrencyBaseValue/baseCurrency
        let totalCost = ((Double(thirdFieldValue) ?? 0.0) * unitCost)
        let dataSource = DataSource()
        dataSource.baseCurrencyAmount = thirdFieldValue + " " + baseCurrencyValue
        dataSource.targetCurrentAmount = "\(totalCost.rounded(toPlaces: 4)) \(targetCurrencyValue)"
        dataSource.rate = unitCost
        return dataSource
    }
    func getCurrencies() {
        guard !manager.isCacheValid else {
            debugPrint("Cache is valid")
            set(list: manager.fetchExchangeRate())
            return
        }
        Network.catalogue { results in
            switch results {
            case .success(let data):
                debugPrint("Cache is expired")
                set(list:  data.conversionRates)
                data.conversionRates.forEach { dict in
                    manager.append(country: dict.key, exchangeRate: dict.value)
                }
                UserDefaultHelper.instance.lastUpdateTimeStamp = Date().currentUnixTimeStamp
            case .failure(let error):
                debugPrint("error in currecny ", error)
            }
        }
    }
    func set(list: ExchangeRate?) {
        pickerData = list  ?? [:]
        pickerData2 = list  ?? [:]
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//extension ContentView: ExchangeDashboardPresenterOutput {
//    func showDashboard(exchangeRate: ExchangeRate) {
//        pickerData = exchangeRate
//        pickerData = exchangeRate
//    }
//
//    func showError(error: GenericResponse) {
//        errorString = error.localizedDescription
//    }
//}
//
