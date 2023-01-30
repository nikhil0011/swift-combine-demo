//
//  ContentView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    var dataSource: DataSource? = getData()
    @State private var firstFieldValue = "Field 1"
    @State private var secondFieldValue = "Field 2"
    @State private var thirdFieldValue = ""
    @State private var showFirstPicker = false
    @State private var showSecondPicker = false
    @State private var pickerData2: ExchangeRate = ["PKR": 1, "INR": 80, "AED": 3.65]
    @State private var pickerData: ExchangeRate = ["USD": 1, "INR": 80, "AED": 3.65]
    @Environment(\.managedObjectContext) private var viewContext
    @State private var errorString: String = ""
    let manager = ConversionRateManager()
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
               
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
                HStack {
                    if showFirstPicker {
                        PickerView(list: pickerData, selectedValue: $firstFieldValue)
                    }
                    if showSecondPicker {
                        PickerView(list: pickerData2, selectedValue: $secondFieldValue)
                    }
                }
               
                    NavigationLink(destination: PreConfirmationView(data: getData())) {
                        Text("Calculate")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(5)
                    }
                
                Text(errorString)
            }
        }.onAppear(perform: {
            getCurrencies()
        })
    }
    private func getData() -> DataSource {
        let baseCurrency = pickerData[firstFieldValue] ?? 0.0
        let targetCurrencyBaseValue = pickerData[secondFieldValue] ?? 0.0
        let unitCost = targetCurrencyBaseValue/baseCurrency
        let totalCost = ((Double(thirdFieldValue) ?? 0.0) * unitCost)
        let dataSource = DataSource()
        dataSource.baseCurrencyAmount = thirdFieldValue + " " + firstFieldValue
        dataSource.targetCurrentAmount = "\(totalCost.rounded(toPlaces: 4)) \(secondFieldValue)"
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
        //            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
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
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
