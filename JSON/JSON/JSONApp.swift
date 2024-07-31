//
//  JSONApp.swift
//  JSON
//
//  Created by Joaquin Villarreal on 10/04/2024.
//

import SwiftUI

@main
struct JSONApp: App {
    var body: some Scene {
        let login = PostViewModel()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
