//
//  SwiftCombineDemoApp.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import SwiftUI

@main
struct SwiftCombineDemoApp: App {
//    let contentView = ContentView(useCase: <#T##ExchangeDashboardUseCase#>)
//    let presenter = ExchangeDashboardPresenter(output: contentView)
//    let useCase = ExchangeDashboardUseCase(output: presenter)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
