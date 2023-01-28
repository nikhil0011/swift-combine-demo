//
//  SwiftCombineDemoApp.swift
//  SwiftCombineDemo
//
//  Created by Admin on 1/28/23.
//

import SwiftUI

@main
struct SwiftCombineDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
