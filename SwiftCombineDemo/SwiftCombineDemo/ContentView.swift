//
//  ContentView.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let manager = ConversionRateManager()
    var body: some View {
        NavigationView {
            List {
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    
                }
            }
            Text("Select an item")
        }.onAppear(perform: {
            getCurrencies()
        })
    }
    func getCurrencies() {
        Network.catalogue { results in
            switch results {
            case .success(let data):
                data.conversionRates.forEach { dict in
                    manager.append(country: dict.key, exchangeRate: dict.value)
                }
                
                sleep(2)
                
                let allRates = manager.fetchExchangeRate()
                debugPrint("Total Coutries available", allRates?.count)
                allRates?.forEach({ dict in
                    debugPrint("Exchange Rate for \(dict.key) is \(dict.value)")
                })
            case .failure(let error):
                debugPrint("error in currecny ", error)
            }
        }
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
