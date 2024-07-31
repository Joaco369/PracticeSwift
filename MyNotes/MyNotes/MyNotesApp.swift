//
//  MyNotesApp.swift
//  MyNotes
//
//  Created by Joaquin Villarreal on 09/04/2024.
//

import SwiftUI

@main
struct MyNotesApp: App {
    let persistenceController = PersistenceController.init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
