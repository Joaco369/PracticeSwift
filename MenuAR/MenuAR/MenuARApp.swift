//
//  MenuARApp.swift
//  MenuAR
//
//  Created by Joaquin Villarreal on 13/06/2024.
//

import SwiftUI

@main
struct MenuARApp: App {
    
    @StateObject var settings = Setting()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
