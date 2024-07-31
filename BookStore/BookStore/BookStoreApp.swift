//
//  BookStoreApp.swift
//  BookStore
//
//  Created by Joaquin Villarreal on 14/05/2024.
//

import SwiftUI

@main
struct BookStoreApp: App {

    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
