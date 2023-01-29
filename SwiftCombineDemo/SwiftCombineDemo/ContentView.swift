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
        guard !manager.isCacheValid else {
            debugPrint("Cache is valid")
            _ = manager.fetchExchangeRate()
            return
        }
        Network.catalogue { results in
            switch results {
            case .success(let data):
                debugPrint("Cache is expired")
                data.conversionRates.forEach { dict in
                    manager.append(country: dict.key, exchangeRate: dict.value)
                }
                UserDefaultHelper.instance.lastUpdateTimeStamp = Date().currentUnixTimeStamp
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
