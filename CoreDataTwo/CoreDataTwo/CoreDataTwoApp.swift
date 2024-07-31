//
//  CoreDataTwoApp.swift
//  CoreDataTwo
//
//  Created by Joaquin Villarreal on 30/04/2024.
//

import SwiftUI
import CoreData

@main
struct CoreDataTwoApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
