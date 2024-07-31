//
//  NotasApp.swift
//  Notas
//
//  Created by Joaquin Villarreal on 08/04/2024.
//

import SwiftUI

@main
struct NotasApp: App {
    let persistenceController = PersistenceController.init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
